
package org.godfat.avatarblock{
import org.godfat.avatarblock.block_imps.BlockImpRandom;
import flash.utils.Dictionary;

public class Option{
  public function Option(){
    this.avatar_width = 56;
    this.avatar_height = 57;

    this.spacer_width = 4;
    this.spacer_height = 3;

    this.block_xcount = 5;
    this.block_ycount = 5;

    this.imp = BlockImpRandom;
    this.make_imp = BlockImpRandom.make_imp;

    this.master = Master;
    this.make_master = Master.make_master;
    this.fake_master = Master.fake_master;
  }

  // i love ruby's method_missing, i hate stupid copy and paste
  public function get imp(): Class{return data_["imp"];}
  public function set imp(a: Class){data_["imp"] = a;}

  public function get master(): Class{return data_["master"];}
  public function set master(a: Class){data_["master"] = a;}

  public function get avatar_width(): Number{return data_["avatar_width"];}
  public function get avatar_height(): Number{return data_["avatar_height"];}
  public function set avatar_width(a: Number){data_["avatar_width"] = a;}
  public function set avatar_height(a: Number){data_["avatar_height"] = a;}

  public function get spacer_width(): Number{return data_["spacer_width"];}
  public function get spacer_height(): Number{return data_["spacer_height"];}
  public function set spacer_width(a: Number){data_["spacer_width"] = a;}
  public function set spacer_height(a: Number){data_["spacer_height"] = a;}

  public function get block_xcount(): int{return data_["block_xcount"];}
  public function get block_ycount(): int{return data_["block_ycount"];}
  public function set block_xcount(a: int){data_["block_xcount"] = a;}
  public function set block_ycount(a: int){data_["block_ycount"] = a;}

  // public function get mode(): String{return data_["mode"];}
  // public function set mode(a: String){data_["mode"] = a;}
  public function get make_imp(): Function{return data_["imp"].make_imp || data_["make_imp"];}
  public function set make_imp(a: Function): void{data_["make_imp"] = a;}

  public function get make_master(): Function{return data_["master"].make_master || data_["make_master"];}
  public function get fake_master(): Function{return data_["master"].fake_master || data_["fake_master"];}
  public function set make_master(a: Function): void{data_["make_master"] = a;}
  public function set fake_master(a: Function): void{data_["fake_master"] = a;}

  public function get block_count(): int{return block_xcount*block_ycount;}
  public function get avatarblock_width(): Number{return avatar_width+spacer_width;}
  public function get avatarblock_height(): Number{return avatar_height+spacer_height;}

  private var data_: Dictionary = new Dictionary();
}

}

class Dummy{}
