
package org.godfat.avatarblock.imp{
import org.godfat.avatarblock.Avatar;
import org.godfat.avatarblock.Block;
import org.godfat.avatarblock.Master;
import flash.utils.setTimeout;

public class BlockImpRandom extends BlockImp{
  static public function make_imp(block: Block): BlockImp{ return new BlockImpRandom(block); }
  function BlockImpRandom(block: Block){ super(block); }
  public override function work(){
    const picked: Avatar = block_make_avatar(pick_master(), function(){
      block_work(picked);
      setTimeout(work, 1000*5);
    });
  }
  public override function pick_master(): Master{
    return block_masters[Helper.rand(block_masters.length)];
  }
}

}
