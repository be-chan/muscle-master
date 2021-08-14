function moreComment () {
  if (document.querySelector('.more')) {
    
    function hiddenComment () {
      let contents = document.querySelectorAll('.comment-show-list li:nth-child(n + 4)'); // 表示数3件 4番目以降の要素取得
      contents.forEach(function (content) {
        content.classList.add('is-hidden');
      });
    }
    
    hiddenComment();
  
    let more = document.querySelector('.more');
    more.addEventListener('click', (e) => {
      e.stopPropagation();
      let hiddenContents = document.querySelectorAll('.comment-show-list li.is-hidden'); 
      hiddenContents = Array.from(hiddenContents) //NodeListから配列
      
      function notHiddenComment (hiddenContents) {
        hiddenThreeContents = hiddenContents.slice(0, 3); //3件取得
        hiddenThreeContents.forEach(function (hiddenContent) {
          hiddenContent.classList.remove('is-hidden')
        });
      }
  
      if(hiddenContents.length <= 3) {
        more.classList.add('fadeout')
        setTimeout(function () {
         more.style.display = "none";
        }); 
        if(more.style.display == "") {
          let reload = document.querySelector('.reload');
          reload.classList.remove('btn-is-hidden');
          reload.addEventListener('click', () => {
            location.reload();
          });
        }
      }
      
      notHiddenComment(hiddenContents);
  
    });  
  }
};
window.addEventListener('load', moreComment);


