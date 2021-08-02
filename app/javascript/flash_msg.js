function flashMsg() {
  const noticeMsg = document.querySelector('.notice');
  const alertMsg = document.querySelector('.alert');
  const timeoutDelay = 4000; //4秒
  const intervalDelay = 20; //20ミリ秒
  const opacitySubVal = 0.01; //opacity値を0.01秒減少させるため

  //flashメッセージを消すための処理
  const noticeDeleteFlashMessage = () => {
    const id = setInterval(() => {
      const opacity = noticeMsg.style.opacity;

      if(opacity > 0) {
        noticeMsg.style.opacity = opacity - opacitySubVal;
      } else {
        noticeMsg.style.display = "none";
        clearInterval(id);
      }
    }, intervalDelay);
  };

  const alertDeleteFlashMessage = () => {
    const id = setInterval(() => {
      const opacity = alertMsg.style.opacity;
      if(opacity > 0) {
        alertMsg.style.opacity = opacity - opacitySubVal;
      } else {
        alertMsg.style.display = "none"
        clearInterval(id);
      } 
    }, intervalDelay);
  };

  //flashメッセージが存在するかを真偽値で判定
  if(!!noticeMsg) {
    noticeMsg.style.opacity = 1
    setTimeout(noticeDeleteFlashMessage, timeoutDelay);
  };

  if(!!alertMsg) {
    alertMsg.style.opacity = 1
    setTimeout(alertDeleteFlashMessage, timeoutDelay);
  }
};

window.addEventListener('load', flashMsg);