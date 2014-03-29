part of entities_table_wc;

class EntitiesTable {
  TableElement table = querySelector('#entities-table');

  EntitiesTable(Entities entities) {
    List<Attribute> essentialAttributes = entities.concept.essentialAttributes;
    
    TableCaptionElement tableCaption = new TableCaptionElement();
    tableCaption.text = entities.concept.codes;
    table.nodes.add(tableCaption);
    
    TableRowElement hRow = new Element.tr();
    for (Attribute attribute in essentialAttributes) {
      TableCellElement thElement = new Element.th();
      thElement.text = attribute.code;
      hRow.nodes.add(thElement);
    }
    table.nodes.add(hRow);
    
    for (ConceptEntity entity in entities) {
      TableRowElement dRow = new Element.tr();
      
      for (Attribute attribute in essentialAttributes) {
        TableCellElement tdElement = new Element.td();
        tdElement.text = entity.getStringFromAttribute(attribute.code);
        dRow.nodes.add(tdElement);
      }
       
      table.nodes.add(dRow);
    }
  }
}


