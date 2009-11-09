
package{
import org.godfat.Image;
import org.godfat.avatarblock.Block;
import org.godfat.avatarblock.Option;
import org.godfat.avatarblock.imp.BlockImpRandom;

import flash.display.Sprite;
import flash.events.Event;

import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.xml.XMLDocument;

public class example{
  public static var root: Sprite;
  public static var text: String;

  public function example(parent: Sprite){
    Image.ie_hack = false;

    const option: Option = new Option();

    option.master = Photo;
    option.imp    = BlockImpRandom;

    option.avatar_width = option.avatar_height = 50;
    option.spacer_width  = 25;
    option.spacer_height = 50;

    option.block_xcount = 3;
    option.block_ycount = 2;

    load_xml(parent, option);
  }

  private function load_xml(parent: Sprite, option: Option){
    var loader = new URLLoader();

    loader.addEventListener(Event.COMPLETE, function(event: Event){
      var xml:XMLDocument = new XMLDocument();
      xml.ignoreWhite = true;
      xml.parseXML(XML(loader.data).toXMLString());

      example.root = Sprite(parent.root);
      example.text = xml.childNodes[0].attributes['description']
      example.root['textarea'].text = example.text

      new Block(xml.childNodes[0], parent, option).move(0, 0);
    });

    loader.load(new URLRequest('example.xml'));
  }
}

}
