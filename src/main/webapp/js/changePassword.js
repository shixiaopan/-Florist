$.validator.setDefaults({
    submitHandler: function () {
        form.submit();
    }
});
$(document).ready(function () {
    $('#form2').validate({
        rules: {
            username: "required",

            password: {
                required: true,
                minlength: 6,
            },
            confirmPassword: {
                required: true,
                minlength: 6,
                equalTo: "#password",
            }
        },
        messages: {
            username: "用户名输入不能为空",

            password: {
                required: "密码输入不能为空",
                minlength: "密码长度不能小于6位",
            },
            confirmPassword: {
                required: "输入不能为空",
                minlength: "密码长度不能小于6位",
                equalTo: "两次密码输入不一致",
            }
        }
    });
});
