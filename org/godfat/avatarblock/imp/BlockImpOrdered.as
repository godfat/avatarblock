
package org.godfat.avatarblock.imp{
import org.godfat.avatarblock.Avatar;
import org.godfat.avatarblock.Master;
import org.godfat.avatarblock.Block;
import flash.utils.setTimeout;

public class BlockImpOrdered extends BlockImp{
  static public function make_imp(block: Block): BlockImp{ return new BlockImpOrdered(block); }
  function BlockImpOrdered(block: Block){ super(block); }
  public override function work(){
    if(disable_) return;

    const region: int = block_pick_region();
    const direct: int = block_pick_direct();
    const xy: Array = Helper.for_xy(region, direct, block_xcount);
    const picked: Avatar = block_make_avatar(
      masters_[xy[1]*block_xcount+xy[0]], function(){
        block_work(picked, region, direct);
        setTimeout(work, 1000*5);
      }
    );
  }
  public override function pick_master(): Master{
    if(block_masters.length > 0){
      masters_.push(block_masters.shift());
      return masters_[masters_.length-1];
    }
    else{
      disable_ = true;
      return block_fake_master();
    }
  }

  private var masters_: Array = new Array();
  private var disable_: Boolean = false;
}

}