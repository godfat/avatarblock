
package org.godfat.avatarblock.imp{
import org.godfat.avatarblock.Avatar;
import org.godfat.avatarblock.Block;
import org.godfat.avatarblock.Master;
import org.godfat.avatarblock.Util;
import flash.utils.setTimeout;

public class BlockImpRandom extends BlockImp{
  static public function make_imp(block: Block): BlockImp{ return new BlockImpRandom(block); }
  function BlockImpRandom(block: Block){ super(block); }

  public override function work(){
    if( block_masters.length == 0 ) return;

    const avatar: Avatar = block_make_avatar(pick_master(), function(){
      block_work(avatar);
      setTimeout(work, 1000*5);
    });
  }

  public override function pick_master(): Master{
    return block_masters[Util.rand(block_masters.length)] || block_fake_master();
  }
}

}
