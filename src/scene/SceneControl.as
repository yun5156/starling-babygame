package scene
{
	import flash.media.Sound;
	import flash.utils.Dictionary;
	
	import UI.MenuMask;
	
	import events.EventConstant;
	
	import media.SoundControl;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;

	public class SceneControl
	{
		private var root:Sprite;
		public var lastScene:Sprite;
		public var currentScene:Sprite;
		public var menuMask:MenuMask=new MenuMask();
		public var bind:Dictionary=new Dictionary();
		static public const SCENE_COVER:String="scene_cover";
		static public const SCENE_LIST:String="scene_list";
		static public const SCENE_LEVEL_0:String="scene_level_0";
		static public const SCENE_LEVEL_1:String="scene_level_1";
		static public const SCENE_LEVEL_2:String="scene_level_2";
		static public const SCENE_LEVEL_3:String="scene_level_3";
		static public const SCENE_LEVEL_4:String="scene_level_4";
		static public const SCENE_LEVEL_5:String="scene_level_5";
		static public const SCENE_LEVEL_6:String="scene_level_6";
		static public const SCENE_LEVEL_7:String="scene_level_7";
		
		public function SceneControl(_root:Sprite)
		{
			root=_root;
			addListeners();
		}
		
		private function addListeners():void
		{
			// 添加侦听
			root.addEventListener(EventConstant.PLAY,onEventPlay);
			root.addEventListener(EventConstant.PAUSE,onEventPause);
			root.addEventListener(EventConstant.TO_COVER,onToCover);
			root.addEventListener(EventConstant.TO_SCENE,onToScene);
			root.addEventListener(EventConstant.TO_LIST,onToList);
			root.addEventListener(EventConstant.CHANGE_SCORE,onChangeScore);
			root.addEventListener(EventConstant.REST,onEventRest);
		}
		
		private function onEventRest(e:Event):void
		{
			showMemuMask(false);
			SoundControl.getInstance().playSound(SoundControl.getInstance().currentSound,int.MAX_VALUE,true);
			var _level:SceneBase=currentScene as SceneBase;
			_level.findNum.rest();
			_level.dispatchEventWith(EventConstant.CHANGE_SCORE,true,"to_0");
		}
		
		private function onChangeScore(e:Event):void
		{
			//更改header显示的分数
			var _scene:SceneBase=e.target as SceneBase;
			if (_scene!=null) 
			{
				var _data:Object=e.data;
				_scene.scoringDevice.changeScoring(_data);
			
				//更改目录显示的分数
				var _sceneList:SceneList=getScene(SCENE_LIST) as SceneList;
				if (_sceneList!=null) 
				{
					var _index:String=_scene.sceneID.substring(12);//scene_level_*
					var txt_score:TextField=_sceneList.content.getChildByName("txt_score_"+_index) as TextField;
					txt_score.text=_scene.scoringDevice.currentScore.toString();
				}
			}
		}
		
		private function onEventPlay(e:Event):void
		{
			// TODO Auto Generated method stub
			showMemuMask(false);
			SoundControl.getInstance().playSound(SoundControl.getInstance().currentSound,int.MAX_VALUE,false);
		}
		
		private function onEventPause(e:Event):void
		{
			// TODO Auto Generated method stub
			showMemuMask(true);
			SoundControl.getInstance().pauseSound();
		}
		
		private function onToCover(e:Event):void
		{
			// TODO Auto Generated method stub
			showScene(SCENE_COVER);
		}
		
		private function onToList(e:Event):void
		{
			// TODO Auto Generated method stub
			showScene(SCENE_LIST);
		}
		private function showMemuMask(show:Boolean):void
		{
			if (show) 
			{
				root.addChild(menuMask);
			}else
			{
				if (root.getChildIndex(menuMask)>0) 
				{
					root.removeChild(menuMask);
				}
			}
		}
		private function onToScene(e:Event):void
		{
			// TODO Auto Generated method stub
			trace(e.data);
			switch(e.data)
			{
				case "0":
				{
					showScene(SCENE_LEVEL_0);
					break;
				}
				case "1":
				{
					showScene(SCENE_LEVEL_1);
					break;
				}
				case "2":
				{
					showScene(SCENE_LEVEL_2);
					break;
				}
				case "3":
				{
					showScene(SCENE_LEVEL_3);
					break;
				}
				case "4":
				{
					showScene(SCENE_LEVEL_4);
					break;
				}
				case "5":
				{
					showScene(SCENE_LEVEL_5);
					break;
				}
				case "6":
				{
					showScene(SCENE_LEVEL_6);
					break;
				}
				case "7":
				{
					showScene(SCENE_LEVEL_7);
					break;
				}
				default:
				{
					break;
				}
			}
		}
		
		
		public function showScene(_sceneID:String):void
		{
			// 旧场景移除掉
			if (lastScene) 
			{
				root.removeChild(lastScene);
			}
			
			//添加显示新场景
			currentScene=getScene(_sceneID);
			root.addChild(currentScene);
			
			lastScene=currentScene;
			
		}
		private function getScene(_sceneID:String):Sprite
		{
			// TODO Auto Generated method stub
			var _scene:Sprite=bind[_sceneID] as Sprite;
			if (_scene) 
			{
				return _scene;
			}else
			{
				switch(_sceneID)
				{
					case SCENE_COVER:
					{
						_scene=new Cover();
						break;
					}
					case SCENE_LIST:
					{
						_scene=new SceneList();
						break;
					}
					case SCENE_LEVEL_0:
					{
						_scene=new SceneLevel0();
						break;
					}
					case SCENE_LEVEL_1:
					{
						_scene=new SceneLevel1();
						break;
					}
					case SCENE_LEVEL_2:
					{
						_scene=new SceneLevel2();
						break;
					}
					case SCENE_LEVEL_3:
					{
						_scene=new SceneLevel3();
						break;
					}
					case SCENE_LEVEL_4:
					{
						_scene=new SceneLevel4();
						break;
					}
					case SCENE_LEVEL_5:
					{
						_scene=new SceneLevel5();
						break;
					}
					case SCENE_LEVEL_6:
					{
						_scene=new SceneLevel6();
						break;
					}
					case SCENE_LEVEL_7:
					{
						_scene=new SceneLevel7();
						break;
					}
					default:
					{
						break;
					}
				}
				
				bind[_sceneID]=_scene;
				return _scene;
			}
			
		}
	}
}