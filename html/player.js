class CageLighterSound {

	constructor() {
		this.audio = new Audio('/html/aanstekersfx.mp3');
		//this.audio.loop = true;
		this.audio.volume = 0.75;
	}

	play() {
		this.audio.load();
		this.audio.play()
	}

	stop() {
		this.audio.pause();
		this.audio.load();
	}

}

var lighter = new CageLighterSound();

window.addEventListener('message', (event) => {
  if(event.data.event == "lighter") {
    lighter.stop();
    lighter.play();
  }
});
