
package org.godfat.avatarblock{

public class Array2{
  public function Array2(width: int, height: int){
    data_   = new Array(width * height);
    width_  = width;
    height_ = height;
    clear();
  }

  public function size():       int{ return width * height; }
  public function get width():  int{ return width_; }
  public function get height(): int{ return height_; }
  // don't call this unless you know what you are doing
  public function get data(): Array{ return data_; }

  public function get(x: int, y: int): *{
    return data_[xy2offset(x, y)];
  }

  public function set(x: int, y: int, value: *): Array2{
    data_[xy2offset(x, y)] = value;
    return this;
  }

  public function find(predicate: Function): *{
    for(var i: int = 0; i < size(); ++i){
      if( predicate(data_[i]) ) return i;
    }
    return null;
  }

  public function xy2offset(x: int, y: int): int{
    return x + y * width;
  }

  public function offset2xy(offset: int): Array{
    return [offset % width, int(offset / width)]
  }

  public function clear(): Array2{
    fill(null);
    return this;
  }

  public function fill(value: *): Array2{
    data_ = data_.map(function(){ return value; });
    return this;
  }

  public function forEach(fun: Function, bind: * = null): Array2{
    data_.forEach(fun, bind);
    return this;
  }

  public function indexOf(value: *): Array{
    const index: int = data_.indexOf(value);
    if(index == -1)
      return [-1, -1];
    else
      return offset2xy(index);
  }

  public function offsetOf(value: *): int{
    return data_.indexOf(value);
  }

  public function toArray(): Array{
    return data_.map(function(v){return v;});
  }

  public function toString(): String{
    var i: int = 0;
    return '[' +
           data_.map(function(v){
                       var result = v ? v : 'null'
                       switch( i++ % width ){
                         case 0:       return '[' + result;
                         case width-1: return       result + ']';
                         default:      return       result;
                       }
                     }).join(', ') +
           ']'
  }

  private var data_:   Array;
  private var width_:  int;
  private var height_: int;
}

}
