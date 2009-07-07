
// NOT WORKING YET!!

package org.godfat.avatarblock.imp{
import org.godfat.avatarblock.Avatar;
import org.godfat.avatarblock.Block;
import org.godfat.avatarblock.Master;
import org.godfat.avatarblock.Util;
import flash.utils.setTimeout;

public class BlockImpShuffle extends BlockImp{
  static public function make_imp(block: Block): BlockImp{
    return new BlockImpShuffle(block);
  }

  function BlockImpShuffle(block: Block){
    super(block);
    masters_left_ = block_masters.map(Util.id); // copy
    Util.shuffle(masters_left_);
  }

  public override function work(){
    if( block_masters.length == 0 ) return;

    const master: Master = pick_master();
    const avatar: Avatar = block_avatars.find(function(i){ return i.master == master; });

    if(avatar) work_old(master, avatar);
    else       work_new(master);
  }

  public override function pick_master(): Master{
    if( masters_left_.length > 0 ){
        masters_used_.push(masters_left_.shift());
        return Util.last(masters_used_);
    }
    else if( masters_used_.length > 0 ){
        masters_left_ = masters_used_;
        masters_used_ = [];
        Util.shuffle(masters_left_);
        return pick_master(); // try again, don't give up
    }
    else{
        return block_fake_master();
    }
  }

  protected function work_new(master: Master){
    const avatar: Avatar = block_make_avatar(
      master, function(){
        block_work(avatar);
        setTimeout(work, 1000*5);
      }
    );
  }

  protected function work_old(master: Master, avatar: Avatar){
    const region_direct: Array = for_region_direct(avatar.x, avatar.y);

    const avatar: Avatar = block_make_avatar(
      master, function(){
        block_work(avatar, region_direct[0], region_direct[1]);
        setTimeout(work, 1000*5);
      }
    );
  }

  protected function for_region_direct(x: int, y: int): Array{
    const region_width:  int = block_avatars.width  - 1;
    const region_height: int = block_avatars.height - 1;
    var region: int;
    var direct: int;

    // TODO: fix this with caculation, not switch...
    // left top corner
    if( x == 0 && y == 0){
      // region = direct = 0;
      region = x + y * region_width;
      direct = 0;
    }
    // right top corner
    else if( x == region_width && y == 0 ){
      x -= 1;
      region = x + y * region_width;
      direct = 1;
    }
    // left bottom corner
    else if( x == 0            && y == region_height ){
      y -= 1;
      region = x + y * region_width;
      direct = 2;
    }
    // right bottom corner
    else if( x == region_width && y == region_height ){
      x -= 1; y -= 1;
      region = x + y * region_width;
      direct = 3;
    }
    else{
      const rand: int = Util.rand(2);
      // left edge
      if( x == 0 ){
        region = x + (y - rand) * region_width;
        direct = rand * 2;
      }
      // right edge
      else if( x == region_width ){
        x -= 1;
        region = x + (y - rand) * region_width;
        direct = rand * 2 + 1;
      }
      // top edge
      else if( y == 0 ){
        region = (x - rand) + y * region_width;
        direct = rand;
      }
      // bottom edge
      else if( y == region_height ){
        y -= 1;
        region = (x - rand) + y * region_width;
        direct = rand + 2;
      }
      // around center
      else{
        const rand2: int = Util.rand(2);
        region = (x - rand) + (y - rand2) * region_width;
        direct = rand + rand2 * 2;
      }
    }

    return [region, direct]
  }

  private var masters_left_: Array = []
  private var masters_used_: Array = []
}

}
