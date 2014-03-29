part of mgmt_contacts;

// http://www.json.org/
// http://jsonformatter.curiousconcept.com/

// lib/mgmt/contacts/json/model.dart

var mgmtContactsModelJson = r'''
{
   "width":990,
   "height":580,
   "boxes":[
      {
         "name":"Contact",
         "entry":true,
         "x":155,
         "y":172,
         "width":80,
         "height":120,
         "items":[
            {
               "sequence":10,
               "name":"email",
               "category":"identifier",
               "type":"Email",
               "init":"",
               "essential":true,
               "sensitive":false
            },
            {
               "sequence":20,
               "name":"firstName",
               "category":"required",
               "type":"String",
               "init":"",
               "essential":true,
               "sensitive":false
            },
            {
               "sequence":30,
               "name":"lastName",
               "category":"required",
               "type":"String",
               "init":"",
               "essential":true,
               "sensitive":false
            },
            {
               "sequence":40,
               "name":"telephone",
               "category":"attribute",
               "type":"String",
               "init":"",
               "essential":false,
               "sensitive":false
            },
            {
               "sequence":50,
               "name":"description",
               "category":"attribute",
               "type":"String",
               "init":"",
               "essential":false,
               "sensitive":false
            }
         ]
      }
   ],
   "lines":[

   ]
}
''';
  