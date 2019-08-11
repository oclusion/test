
document.documentElement.scrollHeight;
const app = new PIXI.Application(window.innerWidth, window.innerHeight, { antialias: true, transparent: true });

//PIXI.settings.SCALE_MODE = PIXI.SCALE_MODES.NEAREST;

document.body.appendChild(app.view);

app.loader
    .add('spritesheet', 'mc.json')
    .load(onAssetsLoaded);

function onAssetsLoaded() {
    const explosionTextures = [];
    let i;

    for (i = 0; i < 26; i++) {
        const texture = PIXI.Texture.from(`Explosion_Sequence_A ${i + 1}.png`);
        explosionTextures.push(texture);
    }

    for (i = 0; i < 50; i++) {
        const explosion = new PIXI.AnimatedSprite(explosionTextures);
        explosion.x = Math.random() * window.innerWidth;
        explosion.y = Math.random() * window.innerHeight;
        explosion.anchor.set(0.5);
        explosion.rotation = Math.random() * Math.PI;
        explosion.scale.set(0.75 + Math.random() * 0.5);
        explosion.gotoAndPlay(Math.random() * 27);
        app.stage.addChild(explosion);
    }

    app.start();
}

setTimeout(
	function(){ 
		window.webkit.messageHandlers.jsHandler.postMessage("Salir");
	}, 
	5000
);













/*
app.loader.add('bunny', 'bunny.png').load((loader, resources) => {
    const bunny = new PIXI.Sprite(resources.bunny.texture);

    bunny.x = app.renderer.width / 2;
    bunny.y = app.renderer.height / 2;

    bunny.anchor.x = 0.5;
    bunny.anchor.y = 0.5;

    app.stage.addChild(bunny);

    app.ticker.add(() => {
        bunny.rotation += 0.01;
    });
});
*/

/*app.loader
	.add('fighter.json')
    .load(onAssetsLoaded);

function onAssetsLoaded() {

    const frames = [];

    for (let i = 0; i < 30; i++) {
        const val = i < 10 ? `0${i}` : i;
        frames.push(PIXI.Texture.from(`rollSequence00${val}.png`));
    }

    const anim = new PIXI.AnimatedSprite(frames);

    anim.x = window.innerWidth / 2;
    anim.y = window.innerHeight / 2;
    anim.anchor.set(0.5);
    anim.animationSpeed = 0.5;
    anim.play();

    app.stage.addChild(anim);

    app.ticker.add(() => {
        anim.rotation += 0.01;
    });
}
*/





