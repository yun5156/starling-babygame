package media
{
    import flash.events.Event;
    import flash.media.Sound;
    import flash.media.SoundChannel;
    
    import starling.events.EventDispatcher;

    public class SoundControl extends EventDispatcher
    {
        private var _currentSound:Sound;
        private var _soundPosition:Number = 0;
        private var _isPlaying:Boolean = false;
        private var soundChannel:SoundChannel;
        public static var SOUND_PLAY:String = "sound_play";
        private static var _instance:SoundControl;

        public function SoundControl(param1:SoundEngineSingleton)
        {
            soundChannel = new SoundChannel();
            if (_instance)
            {
                throw new ArgumentError("SoundControl is a Singleton class. Use getInstance().");
            }
            return;
        }// end function

        public function playSound(_sound:Sound, _loop:uint, _anew:Boolean) : void
        {
			if (isPlaying) 
			{
				_soundPosition=soundChannel.position;
			}
            soundChannel.stop();
			
            if (!_anew && _sound == _currentSound)
            {
				soundChannel = _sound.play(_soundPosition,0);
              	soundChannel.addEventListener(Event.SOUND_COMPLETE,function onSoundComplete():void
				{
					soundChannel.removeEventListener(Event.SOUND_COMPLETE,onSoundComplete);
					soundChannel = _sound.play(0,_loop);
				});
            }else
            {
				soundChannel = _sound.play(0,_loop);
            }
            _isPlaying = true;
            _currentSound = _sound;
            this.dispatchEventWith(SOUND_PLAY, false);
            return;
        }// end function
		
        public function pauseSound() : void
        {
            _soundPosition = soundChannel.position;
            soundChannel.stop();
            _isPlaying = false;
            return;
        }// end function

        public function get currentSound() : Sound
        {
            return _currentSound;
        }// end function

        public function get isPlaying():Boolean
        {
            return _isPlaying;
        }// end function

        public static function getInstance() : SoundControl
        {
            if (!_instance)
            {
                _instance = new SoundControl(new SoundEngineSingleton());
            }
            return _instance;
        }// end function
    }
}
class SoundEngineSingleton{};
