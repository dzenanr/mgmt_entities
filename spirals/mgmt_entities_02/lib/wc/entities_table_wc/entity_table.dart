part of entities_table_wc;

class EntityTable { 
  Entities entities;
  Attributes attributes;
  
  TableElement table = querySelector('#entity-table');
  ButtonElement addButton = querySelector('#add-button');
  ButtonElement cancelButton = querySelector('#cancel-button');
  
  EntitiesTable entitiesTable;
  
  EntityTable(this.entitiesTable, this.entities) {   
    attributes = entities.concept.attributes;
    display();
    addEventHandlers();
    firstField().focus();
  } 
  
  display() {
    addCaption();
    for (Attribute attribute in attributes) {
      addRow(attribute);
    }
  }
  
  addCaption() {
    var tableCaption = new TableCaptionElement();
    tableCaption.text = entities.concept.code;
    table.nodes.add(tableCaption);
  }
  
  addRow(Attribute attribute) {
    TableRowElement row = new Element.tr();
    
    TableCellElement thElement = new Element.th();
    thElement.text = attribute.code;
    row.nodes.add(thElement);
    
    TableCellElement tdElement = new Element.td();
    var inputElement = new InputElement();
    inputElement.classes.add('field');
    if (attribute.required) {
      inputElement.attributes['required'] = 'required';
    }
    tdElement.nodes.add(inputElement);
    row.nodes.add(tdElement);
    
    row.id = attribute.oid.toString();
    table.nodes.add(row);
  }
  
  InputElement firstField() {
    return table.rows[0].nodes[1].nodes[0];
  }
  
  InputElement rowField(TableRowElement row) {
    return row.nodes[1].nodes[0];
  }
  
  addEventHandlers() {
    addButton.onClick.listen(addEntity);
    cancelButton.onClick.listen(cancelAction);
  }
  
  TableRowElement findRow(Attribute attribute) {
    for (int i = 0; i < table.rows.length; i++) {
      TableRowElement row = table.rows[i];
      if (row.id == attribute.oid.toString()) {
        return row;
      } 
    }
    return null;
  }
  
  addEntity(Event e) {
    var newEntity = entities.newEntity();
    for (Attribute attribute in attributes) {
      var row = findRow(attribute);
      var value = rowField(row).value;
      if (value != null) {
        newEntity.setStringToAttribute(attribute.code, value);
      }
    }
    var added = entities.add(newEntity);
    entitiesTable.display();
    entitiesTable.save();
  }
  
  cancelAction(Event e) {
    emptyData();
    firstField().focus();
  }
  
  emptyData() {
    for (int i = 0; i < table.rows.length; i++) {
      TableRowElement row = table.rows[i];
      var field = rowField(row);
      field.value = '';
    }
  }
}