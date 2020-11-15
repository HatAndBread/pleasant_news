const speakButt = document.getElementById('speak_butt');
const cancelButt = document.getElementById('cancel_butt');
const bodyText = document.getElementById('main_body').innerText;

speakButt.addEventListener('click', () => {
  let utterance = new SpeechSynthesisUtterance(bodyText);
  window.speechSynthesis.speak(utterance);
});

cancelButt.addEventListener('click', () => {
  window.speechSynthesis.cancel();
});
