# healthier2

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# subscribe codes
``` 
ElevatedButton(
                              //TODO: save prescription to database
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: lightColorScheme.primary,
                                  shape: StadiumBorder(
                                      side: BorderSide(
                                          color: lightColorScheme.primary))),
                              child: KTextStyle(
                                text: "Prescribe",
                                color: lightColorScheme.onPrimary,
                                size: 14.0,
                              ),
                            )
```
Feedback
--------
- Clinician should see pdf report of patient using App between two dates, along with their  comments and prescriptions 
- Report should should be able to filtered based on keys like, medicine name, illness, delayed prescriptios
- Implementing Notifications 
- App should be downloaded on playstore
- Call Katende once everything is ready
- Preparing full tools for presenting my project `personal internet, mobile phone`
- Auntentication 

## Errors
it happens when user taps on texfield to fetch temperature
#achievements
by entering phone prescription is saved to correct patient 🆗


verify
-----
Pharmacist phone
Patient phone

Then pharmacist has to be saved in db
Secondly, related prescriptions to given patient number  are retrieved from db 
finally pharmacist can

## Convert all lists into table or pdf for reports
look into specific objectives

patientId, prescriptionId, medicineId,  

selecting between dates 

```  
let start = new Date('2017-01-01');
let end = new Date('2018-01-01');

this.afs.collection('invoices', ref => ref
  .where('dueDate', '>', start)
  .where('dueDate', '<', end)
);

```
5tr@GN