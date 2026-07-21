import funkin.visuals.objects.VideoSprite;

for (char in ["fysd_phase_1", "fysd_phase_2", "fysd_phase_3", "fysd_phase_4_lord", "fysd_phase_4_bob", "fysd_phase_5", "fysd_subaru"]) cacheCharacter(char);

function postCreate() {
	camGame.bgColor = FlxColor.WHITE;

	for (i in 0...9)
	{
   	 stage.get("fb_" + (i + 1)).alpha = 0;
    }
    stage.get("desmotivacion").alpha = 0;
    stage.get("jellyfield").alpha = 0;
    gf.alpha = 0;
    
    stage.get("fb_9").cameras = [camHUD];
    stage.get("fb_9").screenCenter();
    
	blackOverlay = new FlxSprite().makeGraphic(1280, 720, FlxColor.BLACK);
    blackOverlay.cameras = [camHUD];
    add(blackOverlay);
    
    introVid = new VideoSprite(0, 0, Paths.video("almendra-pelada"), false);
    introVid.cameras = [camHUD];
    add(introVid);
    
    memeVid = new VideoSprite(0, 0, Paths.video("hot-milk"), false, false, null, () -> {
		memeVid.visible = false;
		camGame.alpha = 1;
	});
    memeVid.cameras = [camHUD];
    insert(0, memeVid);
    
    lyricVid = new VideoSprite(0, 0, Paths.video("porno"), false, false, null, () -> lyricVid.visible = false);
    lyricVid.cameras = [camHUD];
    insert(0, lyricVid);
    
    healthBar.alpha = 0;
    iconP1.visible = false;
    iconP2.visible = false;
    
    opponentStrumLines.members[0].alpha = 0;
}

function onSafeStepHit(curStep:Int) {
	if (curStep == 1) {
		introVid.play();
	}
	
	if (curStep == 8) {
        FlxTween.tween(blackOverlay, {alpha: 0}, 1.5, {
	        onComplete: function(twn:FlxTween) {
	            remove(blackOverlay);
	            blackOverlay.destroy();
	        }
	    });
    }

    if (curStep == 192) {
        FlxTween.tween(camGame.scroll, {y: camGame.scroll.y - 2000}, 7);
        FlxTimer.wait(6, () -> FlxTween.tween(introVid, {alpha: 0}, 0.5));
    }
    
    if (curStep == 480) {
    	camGame.targetZoom = 0.65;
        FlxTween.tween(stage.get("jellyfield"), {alpha: 1}, 1);
    }

    if (curStep == 660) {
    	moveCamera(dad);
        camGame.tweenPosition(camGame.position.x, camGame.position.y, 1.6, {ease: FlxEase.quartInOut});
    }
    
    if (curStep == 860) {
        FlxTween.tween(camGame, {alpha: 0}, 0.5);
    }
    
    if (curStep == 864) {
        memeVid.play();
        dad.visible = false;
        changeCharacter(bf, "fysd_phase_3");
        stage.get("jellyfield").alpha = 0;
        stage.get("bedrom").alpha = 0;
    }

    if (curStep == 1296) {
        FlxTween.tween(stage.get("fb_1"), {alpha: 1}, 1);
        FlxTween.tween(stage.get("fb_1"), {x: stage.get("fb_1").x + 200}, 20);
    }

    if (curStep == 1344) {
        FlxTween.tween(stage.get("fb_1"), {alpha: 0}, 1);
        FlxTween.tween(stage.get("fb_2"), {alpha: 1}, 1);
        FlxTween.tween(stage.get("fb_2"), {x: stage.get("fb_1").x - 200}, 20);
    }

    if (curStep == 1393) {
        FlxTween.tween(stage.get("fb_2"), {alpha: 0}, 1);
        FlxTween.tween(stage.get("fb_3"), {alpha: 1}, 1);
        FlxTween.tween(stage.get("fb_3"), {y: stage.get("fb_3").y - 200}, 20);
    }

    if (curStep == 1416) {
        FlxTween.tween(stage.get("fb_3"), {alpha: 0}, 0.6);
        FlxTween.tween(stage.get("fb_4"), {alpha: 1}, 0.6);
        FlxTween.tween(stage.get("fb_4"), {y: stage.get("fb_3").y + 200}, 20);
    }

    if (curStep == 1440) {
        FlxTween.tween(stage.get("fb_4"), {alpha: 0}, 1);
        FlxTween.tween(stage.get("fb_5"), {alpha: 1}, 1);
        FlxTween.tween(stage.get("fb_5"), {x: stage.get("fb_5").x + 200}, 20);
    }

    if (curStep == 1488) {
        FlxTween.tween(stage.get("fb_5"), {alpha: 0}, 1);
        FlxTween.tween(stage.get("fb_6"), {alpha: 1}, 1);
        FlxTween.tween(stage.get("fb_6"), {x: stage.get("fb_6").x - 200}, 20);
    }

    if (curStep == 1536) {
        FlxTween.tween(stage.get("fb_6"), {alpha: 0}, 1);
        FlxTween.tween(stage.get("fb_7"), {alpha: 1}, 1);
        FlxTween.tween(stage.get("fb_7").scale, {x: 0.7, y: 0.7}, 20);
    }

    if (curStep == 1572) {
        FlxTween.tween(stage.get("fb_7"), {alpha: 0}, 1);
        FlxTween.tween(stage.get("fb_8"), {alpha: 1}, 1);
        FlxTween.tween(stage.get("fb_8").scale, {x: 0.7, y: 0.7}, 20);
    }

    if (curStep == 1608) {
    	camGame.alpha = 0;
        stage.get("fb_8").alpha = 0;
        stage.get("fb_9").alpha = 1;
        FlxTween.tween(camHUD, {alpha: 0}, 0.5, {startDelay: 0.5});
        changeCharacter(bf, "fysd_phase_4_bob");
  	  changeCharacter(dad, "fysd_phase_4_lord");
    }

    if (curStep == 1632) {
        stage.get("fb_9").alpha = 0;
        dad.visible = true;
        FlxTween.tween(camGame, {alpha: 1}, 1);
        FlxTween.tween(camHUD, {alpha: 1}, 1, {startDelay: 1});
    }

    if (curStep == 2016) {
        FlxTween.tween(stage.get("citi"), {alpha: 0}, 0.5);
        FlxTween.tween(boyfriend, {alpha: 0}, 0.5);
        FlxTween.tween(dad, {alpha: 0}, 0.5);
    }
    
    if (curStep == 2088) {
        lyricVid.play();
    }

    if (curStep == 2400) {
  	  changeCharacter(bf, "fysd_phase_5");
  	  changeCharacter(dad, "fysd_subaru");
        boyfriend.alpha = 0;
        dad.alpha = 0;
    }

    if (curStep == 2484) {
    	boyfriend.x -= 350;
    	moveCamera(dad);
    	allowCameraMoving = false;
    	camGame.position.x += 75;
        FlxTween.tween(boyfriend, {alpha: 1}, 1.5);
        FlxTween.tween(boyfriend, {x: boyfriend.x + 200}, 20);
    }

    if (curStep == 2568) {
        FlxTween.tween(dad, {alpha: 1}, 1.5);
        FlxTween.tween(dad, {x: dad.x - 200}, 20);
    }

    if (curStep == 2664) {
        FlxTween.tween(dad, {alpha: 0}, 1.5);
    }
    
    if (curStep == 2688) {
  	  FlxTween.tween(boyfriend, {alpha: 0}, 1.5);
    	FlxTween.tween(camHUD, {alpha: 0}, 2);
    }

    if (curStep == 2760) {
    	camGame.targetZoom = 0.8;
  	  FlxTween.tween(stage.get("desmotivacion"), {alpha: 1}, 2.5);
    }
}