
package org.godfat.avatarblock.block_imps{
import org.godfat.avatarblock.Master;
import org.godfat.avatarblock.Block;

public class BlockImpStatic extends BlockImp{
  static public function make_imp(block: Block): BlockImp{ return new BlockImpStatic(block); }
  function BlockImpStatic(block: Block){ super(block); }
  public override function work(){}
  public override function pick_master(): Master{
    if(block_masters.length > 0)
      return block_masters.shift();
    else
      return block_fake_master();
  }
}

}
