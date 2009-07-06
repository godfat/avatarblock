
package{
import org.godfat.avatarblock.Avatar;
import org.godfat.avatarblock.Master;

import flash.events.MouseEvent;
import flash.net.navigateToURL;
import flash.net.URLRequest;
import flash.xml.XMLNode;

class Photo extends Master{
  static public function make_master(data: XMLNode): Master{ return new Photo(data); }

  public function Photo(data: XMLNode){ super(data); }
  public override function get avatar_uri(): String{
    return attr('img_attr')['src'];
  }

  public override function on_avatar_init(a: Avatar){
    if(a){
      a.body.useHandCursor = true;
      a.body.buttonMode = true;
    }
  }

  public override function on_click(event: MouseEvent){
    const uri: String = attr('a_attr')['href'] + '/' + attr('a')
    example.root['textarea'].text = example.text + uri;
    // navigateToURL(new URLRequest(uri), "_blank");
  }
}

}
