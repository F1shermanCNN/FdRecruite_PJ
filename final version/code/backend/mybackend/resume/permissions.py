from rest_framework import permissions

class IsOwnerOrReadOnly(permissions.BasePermission):
    """
    自定义权限：对象级别权限控制，仅允许对象的所有者进行修改，其余用户只能读取。
    假设对象上有 `user` 属性。
    """

    def has_object_permission(self, request, view, obj):
        # 安全方法允许所有用户访问
        if request.method in permissions.SAFE_METHODS:
            return True

        # 写权限仅允许对象的 owner（即 obj.user == 当前登录用户）访问
        return obj.user == request.user
    
    