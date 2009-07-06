
package org.godfat.avatarblock.imp{
import org.godfat.avatarblock.Avatar;
import org.godfat.avatarblock.Array2;
import org.godfat.avatarblock.Block;
import org.godfat.avatarblock.Master;

public class BlockImp{
  // add this factory method to your imp class
  static public function make_imp(block: Block): BlockImp{ return undefined; }
  /*protected*/ function BlockImp(block: Block){ block_ = block; }
  // please override these two methods
  // p.s. public to PrivateBlock(internal) + BlockImp's derivion(protected)
  //      otherwise, don't call it.
  //      i think C++ is better in access control
  //      e.g., private c'tor, friend class, etc.
  public function work(){ throw new ArgumentError("don't even call this."); }
  public function pick_master(): Master{ return undefined; }

  protected function get block(): Block{ return block_; }
  protected function get block_masters(): Array { return block.masters; }
  protected function get block_avatars(): Array2{ return block.avatars; }
  protected function get block_xcount(): int{ return block.xcount; }
  protected function get block_ycount(): int{ return block.ycount; }
  protected function get block_count(): int{ return block.count; }
  protected function block_work(picked: Avatar, region: int = -1, direct: int = -1){
    block.work(picked, region, direct);
  }
  protected function block_clear_avatars(): BlockImp{
    block.clear_avatars();
    return this;
  }
  protected function block_set_avatar(x: int, y: int, a: Avatar): BlockImp{
    block.set_avatar(x, y, a);
    return this;
  }
  protected function block_make_avatar(master: Master, callback: Function = null,
    x: Number = 0, y: Number = 0): Avatar
  {
    return block.make_avatar(master, callback, x, y);
  }
  protected function block_fake_master(): Master{ return block.fake_master(); }
  protected function block_pick_region(): int{ return block.pick_region(); }
  protected function block_pick_direct(): int{ return block.pick_direct(); }

  private var block_: Block;
}

}
