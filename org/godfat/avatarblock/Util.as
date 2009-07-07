
package org.godfat.avatarblock{
import flash.utils.Dictionary;
import flash.xml.XMLNode;

public class Util{
  static public function strip(s: String): String{
    return s.replace(/^\s+/g, "").replace(/\s+$/g, "");
  }

  static public function clear(a: Array): Array{
    a.splice(0, a.length);
    return [];
  }

  static public function last(a: Array): *{ return a[a.length-1]; }

  static public function shuffle(a: Array): Array{
    const s: int = a.length
    for(var j: int = 0; j<s; ++j){
      const i: int = Util.rand(s-j)
      const tmp: * = a[j]
      a[j] = a[j+i]
      a[j+i] = tmp
    }
    return a;
  }

  static public function id(a: *): *{ return a; }

  static public function rotate(a: Array): Array{
    a.unshift(a.pop());
    return a;
  }

  static public function rand(n: int): int{ return int(Math.random()*n); }

  static public function loadXML(data: Dictionary, source: XMLNode){
    for each(var node: XMLNode in source.childNodes){
      data[node.nodeName] = node.childNodes[0];
      data[node.nodeName + "_attr"] = node.attributes;
    }
  }

  static public function for_xy(region: int, direct: int, xcount: int): Array{
    return [   (region % (xcount-1)) + x_offset(direct),
            int(region / (xcount-1)) + y_offset(direct)];
  }
  static public function x_offset(direct: int): int{
    // 0 1
    // 2 3
    switch(direct){
      case 0: return 0;
      case 1: return 1;
      case 2: return 0;
      case 3: return 1;
      default: no_such_direct(direct);
    }
    return undefined;
  }

  static public function y_offset(direct: int): int{
    // 0 1
    // 2 3
    switch(direct){
      case 0: return 0;
      case 1: return 0;
      case 2: return 1;
      case 3: return 1;
      default: no_such_direct(direct);
    }
    return undefined;
  }

  static private function no_such_direct(direct: int): void{
    throw new ArgumentError("no such direct: " + direct.toString());
  }
}

}
