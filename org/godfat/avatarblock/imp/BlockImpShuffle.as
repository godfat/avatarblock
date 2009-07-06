
// NOT WORKING YET!!

package org.godfat.avatarblock.imp{
import org.godfat.avatarblock.Avatar;
import org.godfat.avatarblock.Block;
import org.godfat.avatarblock.Master;
import org.godfat.avatarblock.Util;
import flash.utils.setInterval;

public class BlockImpShuffle extends BlockImp{
  static public function make_imp(block: Block): BlockImp{
    return new BlockImpShuffle(block);
  }

  function BlockImpShuffle(block: Block){
    super(block);
    Util.shuffle(block_masters);
  }

  public override function work(){
    const picked: Master = pick_master();
    const avatar: Avatar = picked.avatar;
    const  index: int = block_avatars.indexOf(avatar);

    if(index[0] == -1) work_new(picked); // -1 indicates not found
    else               work_old(picked, index[0], index[1]);
  }

  public override function pick_master(): Master{
    return Util.last(Util.rotate(block_masters));
  }

  protected function work_new(picked: Master){
    const avatar: Avatar = block_make_avatar(
      picked, function(){
        block_work(avatar);
        setTimeout(work, 1000*5);
      }
    );
  }

  protected function work_old(picked: Master, x: int, y: int){
    var region: int = 0;
    var direct: int = 0;

    // TODO: fix this with caculation, not switch...
    if( x == 0 && y == 0){
      region = direct = 0;
    }
    else if( x == block_avatars.width - 1 && y == 0 ){
      region = x - 1;
      direct = 1;
    }
    else if( x == 0                       && y == block_avatars.height - 1 ){
      region = y - 1;
    }

    const avatar: Avatar = block_make_avatar(
      picked, function(){
        block_work(avatar, region, direct);
        setTimeout(work, 1000*5);
      }
    );
  }

  private var masters_: Array = new Array();
}

}
