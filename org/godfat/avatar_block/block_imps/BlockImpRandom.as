
package org.godfat.avatar_block.block_imps{
import org.godfat.avatar_block.Avatar;
import org.godfat.avatar_block.Master;
import org.godfat.avatar_block.Block;
import org.godfat.Helper;
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
