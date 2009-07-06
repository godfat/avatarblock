
package org.godfat.avatarblock{
import flash.display.Sprite;
import flash.net.URLRequest;
import flash.utils.setInterval;
import flash.utils.clearInterval;
import flash.events.MouseEvent;

public class Avatar{
  public function Avatar(owner: Master, parent: Sprite,
    option: Option, callback: Function = null, x: Number = 0, y: Number = 0)
  {
    owner_ = owner;
    parent_ = parent;
    option_ = option;
    body_ = Sprite(parent_.addChild(new Sprite()));
    img_ = new Image(owner_.avatar_uri, body_, option_.avatar_width, option_.avatar_height, callback);
    img_.mask = new Mask();

    var frame: Frame = new Frame();
    frame.width = option_.avatar_width +1; frame.height = option_.avatar_height +1;
    body_.addChild(frame);

    // init click event
    body_.addEventListener(MouseEvent.CLICK, owner_.on_click);

    // init callback
    owner_.on_avatar_init(this);

    move(x, y);
  }

  public function cleanup(){
    img_.cleanup();
    img_ = null;
    parent_.removeChild(body_);
    body_ = null;
    parent_ = null;
    owner_ = null;
  }

  public function move(x: Number, y: Number){ body_.x = x; body_.y = y; }
  public function get body(): Sprite{ return body_; }

  public function fade_out(callback: Function = null){
    var step: int = 0;
    const pid: int = setInterval(function(){
      body_.alpha = 1 - step++ * 1 / 20;
      if(body_.alpha <= 0){
        clearInterval(pid);
        if(callback != null) callback();
      }
    }, 1000/30);
  }
  public function fade_in(callback: Function = null){
    var step: int = 0;
    const pid: int = setInterval(function(){
      body_.alpha = step++ * 1 / 40;
      if(body_.alpha >= 1){
        clearInterval(pid);
        if(callback != null) callback();
      }
    }, 1000/30);
  }
  public function no_alpha(){ body_.alpha = 0; }
  public function full_alpha(){ body_.alpha = 1; }
  public function expand(region: int){
    body_.width = option_.avatar_width*2 + option_.spacer_width +1;
    body_.height = option_.avatar_height*2 + option_.spacer_height +1;
    const xy: Array = Util.for_xy(region, 0, option_.block_xcount);
    move(xy[0]*option_.avatarblock_width, xy[1]*option_.avatarblock_height);
  }
  public function slide_to(direct: int, callback: Function = null){
    // see Util#x_offset/y_offset
    const target_x: int = body_.x + option_.spacer_width + option_.avatar_width*Util.x_offset(direct);
    const target_y: int = body_.y + option_.spacer_height + option_.avatar_height*Util.y_offset(direct);
    body_.x -= Util.x_offset(direct);
    body_.y -= Util.y_offset(direct);

    const pid: int = setInterval(function(){
      if( is_slide_done() ){
        slide_adjust(direct, target_x, target_y);

        clearInterval(pid);
        if(callback != null)
          callback();
      }
      else{
        slide_position_fix(direct, function(){
          body_.x += body_.width * 0.1;
        }, function(){
          body_.y += body_.height * 0.1;
        });
        slide_scale_step(); // don't change the calling order between the two
      }
    }, 1000/30);
  }

  private function slide_position_fix(direct: int, fix_x: Function, fix_y: Function){
    var need_fix_x = false;
    var need_fix_y = false;
    switch(direct){
      case 0: // left-up
        break; // do nothing;
      case 1: // right-up
        need_fix_x = true; break;
      case 2: // left-down
        need_fix_y = true; break;
      case 3: // right-down
        need_fix_x = need_fix_y = true; break;
    }
    if(need_fix_x) fix_x();
    if(need_fix_y) fix_y();
  }

  private function slide_scale_step(){
    body_.width *= 0.9;
    body_.height *= 0.9;
  }

  private function is_slide_done(): Boolean{
    return body_.width*0.9 <= option_.avatar_width;
  }

  private function slide_adjust(direct: int, target_x: int, target_y: int){
    // other than left-up, we need to adjust position
    slide_position_fix(direct, function(){
      body_.x = target_x;
    }, function(){
      body_.y = target_y;
    });
    // always adjust scale
    body_.width = option_.avatar_width;
    body_.height = option_.avatar_height;
  }

  private var owner_: Master;
  private var parent_: Sprite;
  private var body_: Sprite;
  private var img_: Image;
  private var option_: Option;
}

}
