part of entities_table_wc;

class EntitiesTable {
  Entities entities;
  List<Attribute> essentialAttributes;
  
  TableElement table = querySelector('#entities-table');
  
  EntitiesTableWc entitiesTableWc;

  EntitiesTable(this.entitiesTableWc, this.entities) {
    essentialAttributes = entities.concept.essentialAttributes;
    display();
  }
  
  display() {
    removeRows();
    addCaption();
    addHeaderRow();
    for (var entity in entities) {
      addDataRow(entity);
    }  
  }
  
  removeRows() {
    table.nodes.clear();
  }
  
  addCaption() {
    var tableCaption = new TableCaptionElement();
    tableCaption.text = entities.concept.codes;
    table.nodes.add(tableCaption);
  }
  
  addHeaderRow() {
    TableRowElement hRow = new Element.tr();
    for (Attribute attribute in essentialAttributes) {
      TableCellElement thElement = new Element.th();
      thElement.text = attribute.code;
      hRow.nodes.add(thElement);
    }
    table.nodes.add(hRow);
  }
  
  addDataRow(ConceptEntity entity) {
    TableRowElement dRow = new Element.tr();
    
    for (Attribute attribute in essentialAttributes) {
      TableCellElement tdElement = new Element.td();
      tdElement.text = entity.getAttribute(attribute.code);
      dRow.nodes.add(tdElement);
    }
     
    dRow.id = entity.oid.toString();
    dRow.onClick.listen(selectEntity);
    table.nodes.add(dRow);
  }
  
  selectEntity(Event e) {
    var dRow = (e.target as TableCellElement).parent;
    var idn = int.parse(dRow.id);
    var entity = entities.singleWhereOid(new Oid.ts(idn));
    entitiesTableWc.entityTable.setEntity(entity);
  }
  
  save() {
    entitiesTableWc.save();
  }
}


