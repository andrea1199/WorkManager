function showPwd() {
    var pwdInput = document.getElementById('password');
    var pwdEye = document.getElementById('pwdEye');
    if (pwdInput.type === 'password') {
      pwdInput.type = 'text';
      pwdEye.classList.remove('fa-eye');
      pwdEye.classList.add('fa-eye-slash');
    } else {
      pwdInput.type = 'password';
      pwdEye.classList.remove('fa-eye-slash');
      pwdEye.classList.add('fa-eye');
    }
  }