
package org.godfat{
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Loader;
import flash.net.URLRequest;
import flash.events.Event;
import flash.events.IOErrorEvent;

public class Image{
  static public var ie_hack: Boolean = false;
  public function Image(uri: String, parent: DisplayObjectContainer,
    width: Number, height: Number,
    callback: Function = null)
  {
    parent_ = parent;
    body_ = new Loader();
    parent_.addChild(body_);
    width_ = width;
    height_ = height;

    body_.contentLoaderInfo.addEventListener(Event.COMPLETE, function(){
      body_.width = width_;
      body_.height = height_;
      callback && callback();
    });
    body_.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, callback || function(){});

    if( Image.ie_hack )
      body_.load(new URLRequest(uri+"?for_suck_ie="+Math.random().toString()));
    else
      body_.load(new URLRequest(uri));
  }
  public function set mask(m: DisplayObject){
    release_mask();
    body_.mask = m;
    m.width = width_;
    m.height = height_;
    parent_.addChild(m);
  }
  public function get mask(){ return body_.mask; }
  function release_mask(){
    if( this.mask == null ) return;
    parent_.removeChild( this.mask );
  }
  public function cleanup(){
    body_.unload();
    parent_.removeChild(body_);
    body_ = null;
    parent_ = null;
  }

  private var parent_: DisplayObjectContainer;
  private var body_: Loader;
  private var width_: Number;
  private var height_: Number;
}

}
