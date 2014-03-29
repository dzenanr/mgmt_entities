part of mgmt_contacts_app;

class ContactsApp {
  ContactsApp(MgmtModels domain) {
    var model = domain.getModelEntries("Contacts"); 
    model.init(); 
    new EntitiesTable(model.contacts);
  }
}

