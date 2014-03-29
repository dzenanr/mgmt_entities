part of mgmt_contacts; 
 
// lib/repository.dart 
 
class Repository extends Repo { 
 
  static const REPOSITORY = "Repository"; 
 
  Repository([String code=REPOSITORY]) : super(code) { 
    var domain = new Domain("Mgmt"); 
    domains.add(domain); 
    add(new MgmtDomain(domain)); 
 
  } 
 
} 
 
