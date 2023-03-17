// 근태관리 실시간 시간 보여주기 
var Target = document.getElementById("clock");
var yearNow = document.getElementById("year");
        function clock() {
            var time = new Date();

            var year = time.getFullYear();
            var month = time.getMonth();
            var date = time.getDate();
            var day = time.getDay();
            var week = ['일', '월', '화', '수', '목', '금', '토'];

            var hours = time.getHours();
            var minutes = time.getMinutes();
            var seconds = time.getSeconds();

            yearNow.innerHTML = `${year}년 ${month + 1}월 ${date}일 (${week[day]})`;
            Target.innerText = 
            `${hours < 10 ? `0${hours}` : hours}:${minutes < 10 ? `0${minutes}` : minutes}:${seconds < 10 ? `0${seconds}` : seconds}`;
                
        }
    clock();
setInterval(clock, 1000); // 1초마다 실행
// 근태관리 실시간 시간 보여주기 end

$('[data-open-details]').click(function (e) {
  e.preventDefault();
  $(this).next().toggleClass('is-active');
  $(this).toggleClass('is-active');
});

