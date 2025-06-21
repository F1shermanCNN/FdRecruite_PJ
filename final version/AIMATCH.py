
import json
import torch
from transformers import AutoTokenizer, AutoModelForCausalLM
from flask import Flask, request, jsonify
from flask_cors import CORS

# 清空 GPU 缓存
torch.cuda.empty_cache()

# 加载本地模型和分词器
model_name = "/home/resume/AIChat/model/Qwen2.5-7B-Instruct"
tokenizer = AutoTokenizer.from_pretrained(model_name)
model = AutoModelForCausalLM.from_pretrained(model_name)

# 将模型加载到 GPU 或 CPU
device = "cuda" if torch.cuda.is_available() else "cpu"
model = model.to(device)

app = Flask(__name__)
# 允许前端跨域请求（前端运行在 http://localhost:8000）
CORS(app, resources={r"/api/*": {"origins": ["http://localhost:8000"]}})

def evaluate_resume_job_match(resume_json, job_json):
    try:
        # 处理 JSON 数据（假设每个 JSON 是一条记录）
        if isinstance(resume_json, list):
            resume_json = resume_json[0]  # 取第一条记录
        if isinstance(job_json, list):
            job_json = job_json[0]  # 取第一条记录

        # 检查 JSON 数据是否包含 'id' 字段
        resume_id = resume_json.get('id', None)
        job_id = job_json.get('id', None)

        if resume_id is None or job_id is None:
            return {
                "resume_id": None,
                "job_id": None,
                "error": "简历或岗位数据中缺少 'id' 字段"
            }

        # 构建提示词
        def create_prompt(resume, job):
            resume_text = ' '.join([f"{k}: {v}" for k, v in resume.items() if k != 'id'])
            job_text = ' '.join([f"{k}: {v}" for k, v in job.items() if k != 'id'])
            prompt = f"""
            你是一个专业的人力资源评估专家。请根据以下岗位要求和求职者简历，评估他们的匹配度。

            岗位信息:
            {job_text}

            求职者简历:
            {resume_text}

            请按照以下结构提供详细信息：

            1. 匹配得分（0-10分）：基于求职者经验和岗位需求的匹配程度给出量化评分。
            2. 匹配理由：解释评分依据，重点说明求职者经验和技能如何满足岗位要求。
            3. 优势和不足：明确指出求职者简历中与岗位匹配的优势和存在的不足。
            4. 建议：针对不足之处，给出具体的改进建议，帮助求职者更好地匹配岗位需求。
            5. 对岗位的适应性分析：
               - 短期适应性：评估求职者当前能力是否能快速适应岗位要求。
               - 长期发展潜力：分析求职者是否有潜力在岗位上实现长期发展。

            6. 对经验的相关性评估：
               - 工作经验：评估求职者的工作经历与岗位职责的相关性。
               - 项目经验：分析求职者参与的项目与岗位需求的契合度。

            7. 技能匹配度：
               - 核心技能：评估求职者的核心技能是否满足岗位的关键要求。（所占权重应该很大）
               - 软技能：考虑求职者的软技能（如沟通能力、团队合作能力）是否适合岗位需求。

            8. 教育背景与培训：
               - 专业相关性：评估求职者的教育背景是否与岗位要求相关。
               - 持续学习：考虑求职者是否有持续学习和自我提升的证据。

            9. 行业与市场洞察：
               - 行业经验：分析求职者在目标行业的经验是否有助于其快速上手。
               - 市场需求：考虑岗位在当前市场中的需求趋势，评估求职者是否具备竞争优势。

            请按照以下JSON格式输出：
            {{
                "score": 7,
                "reason": "求职者有相关技能和经验，但缺乏特定领域的项目经历",
                "strengths": ["5年Python开发经验", "熟悉Django框架"],
                "weaknesses": ["没有电商领域经验", "不熟悉AWS云服务"],
                "suggestions": ["学习AWS相关技术", "补充电商领域项目经验"]
            }}
            """
            return prompt

        prompt = create_prompt(resume_json, job_json)
        print(f"提示词已创建，准备调用模型进行推理")

        # 调用模型
        inputs = tokenizer(prompt, return_tensors="pt", max_length=512, truncation=True).to(device)
        print(f"输入已编码，开始生成模型输出")

        outputs = model.generate(**inputs, max_new_tokens=500, temperature=1.0)
        assessment_text = tokenizer.decode(outputs[0], skip_special_tokens=True)
        cleaned_assessment_text = assessment_text.strip()

        if cleaned_assessment_text.startswith("```json") and cleaned_assessment_text.endswith("```"):
            cleaned_assessment_text = cleaned_assessment_text[7:-3].strip()

        # 检查返回内容是否为空
        if not cleaned_assessment_text:
            return {
                "resume_id": resume_json["id"],
                "job_id": job_json["id"],
                "error": "模型返回的内容为空"
            }

        try:
            assessment = json.loads(cleaned_assessment_text)
        except json.JSONDecodeError as e:
            print(f"解析JSON失败: {e}")
            print(f"清理后的返回内容: {cleaned_assessment_text}")
            return {
                "resume_id": resume_json["id"],
                "job_id": job_json["id"],
                "error": f"JSON解析失败: {e}"
            }

        return {
            "resume_id": resume_json["id"],
            "job_id": job_json["id"],
            "score": assessment["score"],
            "reason": assessment["reason"],
            "strengths": assessment["strengths"],
            "weaknesses": assessment["weaknesses"],
            "suggestions": assessment["suggestions"]
        }

    except Exception as e:
        print(f"处理简历 {resume_json.get('id', '未知')} 和岗位 {job_json.get('id', '未知')} 时出错: {e}")
        return {
            "resume_id": resume_json.get("id", None),
            "job_id": job_json.get("id", None),
            "error": str(e)
        }

@app.route('/api/match_resume_job', methods=['POST'])
def match_resume_job():
    try:
        data = request.get_json()
        resume_json = data.get('resume_json')
        job_json = data.get('job_json')

        if not resume_json or not job_json:
            return jsonify({"error": "缺少简历或岗位数据"}), 400

        result = evaluate_resume_job_match(resume_json, job_json)
        return jsonify(result), 200

    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000, debug=True)
