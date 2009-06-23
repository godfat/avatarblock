
// 0. pick up a photo(friend)
// 1. select a region(4x sized block)
// 2. select a direction(4 selections)
// 3. get the picked on the top-depth, and fade-in it
// 4. fade-out the 4 photos below the picked
// 5. whenever the fade-in/out is finished,
//    place back the alpha of the 4, zoom out the picked
// 6. _x, _y changed depends on the direction
// 7. whenever the zoom out is done, swap the depth
//    between the picked and the out.
// 8. remove the out.
// 9. back to 0.

package org.godfat.avatar_block.block_imps{
import org.godfat.avatar_block.Avatar;
import org.godfat.avatar_block.Master;
import org.godfat.avatar_block.Option;
import org.godfat.Helper;
import de.polygonal.ds.Array2;
import flash.display.DisplayObjectContainer;
import flash.xml.XMLNode;
import flash.utils.setTimeout;

public class PrivateBlock{
  // public static const Width: int = 3;
  // public static const Height: int = 2;
  // public static const Size: int = Width*Height;
  function PrivateBlock(source: XMLNode, parent: DisplayObjectContainer, option: Option)
  {
    source_ = source;
    parent_ = parent;
    option_ = option;

    masters_ = new Array();
    avatars_ = new Array2(xcount, ycount);
    fake_master_ = option_.fake_master();

    // init data
    for each(var data: XMLNode in source_.childNodes)
      masters_.push(option_.make_master(data));

    // init mode
    // please get rid of these
    // switch(option_.mode){
      // case "random": imp_ = new BlockImpRandom(this); break;
      // case "static": imp_ = new BlockImpStatic(this); break;
      // case "ordered": imp_ = new BlockImpOrdered(this); break;
      // case "nokia": imp_ = new BlockImpNokia(this); break;
      // default: imp_ = new BlockImpOrdered(this);
    // }
    // imp_ = new option_.mode(this);
    imp_ = option_.make_imp(this);
    init_mode(imp_.work);
  }

  public function move(x: Number, y: Number){ parent_.x = x; parent_.y = y; }

  internal function get masters(): Array{ return masters_; }
  // internal function get avatars(): Array2{ return avatars_; }
  internal function get xcount(): int{ return option_.block_xcount; }
  internal function get ycount(): int{ return option_.block_ycount; }
  internal function get count(): int{ return option_.block_count; }

  internal function work(picked: Avatar, region: int = -1, direct: int = -1){
    //const friend: ccc = pick_friend();
    //const picked: ccc = pick_avatar();
    //const region: int = pick_region();
    //const direct: int = pick_direct();
    //const shadow: ccc = pick_shadow();
    //const zombie: ccc = pick_zombie();

    if(region == -1) region = pick_region();
    if(direct == -1) direct = pick_direct();

    const shadow: Array = pick_shadow(region);
    const zombie: Avatar = pick_zombie(region, direct);

    picked.no_alpha();
    picked.expand(region);
    picked.fade_in(function(){
      for each(var s in shadow)
        s.full_alpha();
      setTimeout(function(){
        picked.slide_to(direct, function(){
          kick_zombie(picked, region, direct, zombie);
        });
      }, 2000);
    });

    for each(var s in shadow)
      s.fade_out();
  }

  private function init_mode(done_callback: Function){
    var loaded: int = 0;
    for(var y: int = 0; y<ycount; ++y)
      for(var x: int = 0; x<xcount; ++x)
        avatars_.set(x, y, new Avatar(pick_master(), parent_, option_, function(){
          if(++loaded == option_.block_count) done_callback();
        }, option_.avatar_block_width*x, option_.avatar_block_height*y));
  }

  internal function clear_avatars(): PrivateBlock{
    avatars_.toArray().forEach(function(i: Avatar, index, array){i.cleanup();});
    avatars_.clear();
    return this;
  }
  internal function set_avatar(x: int, y: int, a: Avatar): PrivateBlock{
    avatars_.set(x, y, a);
    a.move(option_.avatar_block_width*x, option_.avatar_block_height*y);
    return this;
  }
  internal function make_avatar(master: Master, callback: Function = null,
    x: Number = 0, y: Number = 0): Avatar
  {
    return new Avatar(master, parent_, option_, callback, x, y);
  }
  internal function fake_master(): Master{ return fake_master_; }
  private  function pick_master(): Master{ return imp_.pick_master(); }
  internal function pick_region(): int{ return Helper.rand(count-xcount-ycount+1); }
  private  function pick_shadow(region: int): Array{
    const result: Array = new Array();
    for(var i=0; i<4; ++i) // for all direct
      result.push(this.pick_zombie(region, i));
    return result;
  }
  internal function pick_direct(): int{ return Helper.rand(4); }
  private  function pick_zombie(region: int, direct: int): Avatar{
    const xy: Array = Helper.for_xy(region, direct, xcount);
    return avatars_.get(xy[0], xy[1]);
  }

  private function kick_zombie(
    picked: Avatar,
    region: int,
    direct: int,
    zombie: Avatar)
  {
    const xy: Array = Helper.for_xy(region, direct, xcount);
    avatars_.set(xy[0], xy[1], picked);
    zombie.cleanup();
  }

  private var source_: XMLNode;
  private var parent_: DisplayObjectContainer;
  private var masters_: Array;
  private var avatars_: Array2;
  private var imp_: BlockImp;
  private var fake_master_: Master;
  private var option_: Option;
}

}
