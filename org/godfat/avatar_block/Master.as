
package org.godfat.avatar_block{
import org.godfat.Helper;
import flash.utils.Dictionary;
import flash.xml.XMLNode;
import flash.xml.XMLDocument;
import flash.events.MouseEvent;

public class Master{
  static public function make_master(data: XMLNode): Master{ return new Master(data); }
  static public function fake_master(): Master{
    var xml: XMLDocument = new XMLDocument();
    xml.ignoreWhite = true;
    xml.parseXML(
      "<Master>" +
      "  <img rdf:resource=\"\"/>" +
      "</Master>");
    return make_master(xml.childNodes[0]);
  }

  public function Master(source: XMLNode = null){
    source_ = source;
    data_ = new Dictionary();
    Helper.loadXML(data_, source_);
  }
  public function attr(name: String){ return data_[name]; }
  public function get avatar_uri(): String{ return ""; }
  public function on_click(event: MouseEvent){}

  public function get avatar(): Avatar{ return avatar_; }
  public function set avatar(a: Avatar){ avatar_ = a; }

  private var source_: XMLNode;
  private var data_: Dictionary;
  private var avatar_: Avatar;
}

}
