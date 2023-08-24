import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

void showNotFoundToast(BuildContext context) {
  showTopSnackBar(
    Overlay.of(context),
    const CustomSnackBar.info(message: "Record not found"),
  );
}

void showSuccessToast(BuildContext context) {
  showTopSnackBar(
    Overlay.of(context),
    const CustomSnackBar.success(message: "Medicine added succesfully"),
  );
}

void showMedicineApprovedToast(BuildContext context) {
  showTopSnackBar(
    Overlay.of(context),
    const CustomSnackBar.success(message: "Medicine is Approved"),
  );
}

void showMedicineTakenToast(BuildContext context) {
  showTopSnackBar(
    Overlay.of(context),
    const CustomSnackBar.success(
        message:
            "Good job, you've informed your clinician how keen you are on this precription"),
  );
}

void showErroroast(BuildContext context) {
  showTopSnackBar(
    Overlay.of(context),
    const CustomSnackBar.error(message: "Please fill required fields"),
  );
}

void showErrorToast(BuildContext context,
    {String msg = "Something went wrong"}) {
  showTopSnackBar(
    Overlay.of(context),
    CustomSnackBar.error(message: msg),
  );
}
// app.netlify.janvierna