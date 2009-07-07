
package org.godfat.avatarblock.imp{
import org.godfat.avatarblock.Block;
import org.godfat.avatarblock.Master;

public class BlockImpStatic extends BlockImp{
  static public function make_imp(block: Block): BlockImp{ return new BlockImpStatic(block); }
  function BlockImpStatic(block: Block){ super(block); }
  public override function work(){}
  public override function pick_master(): Master{
    return block_masters.shift() || block_fake_master();
  }
}

}
