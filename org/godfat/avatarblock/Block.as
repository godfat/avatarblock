
package org.godfat.avatarblock{
  import org.godfat.avatarblock.block_imps.PrivateBlock;
  import flash.xml.XMLNode;
  import flash.display.Sprite;
  public class Block extends PrivateBlock{
    public function Block(source: XMLNode, parent: Sprite, option: Option)
    { super(source, parent, option); }
  }
}
