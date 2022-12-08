import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:flutter_api_call/api/user/model/user_model.dart';
import 'package:flutter_api_call/api/user/repository/user_repository.dart';

class UpdateUserPage extends StatefulWidget {
  User user;
  UpdateUserPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<UpdateUserPage> createState() => _UpdateUserPageState();
}

class _UpdateUserPageState extends State<UpdateUserPage> {
  bool shouldPop = true;
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  void dispose() {
    _formKey.currentState?.reset();
    super.dispose();
  }

  void _onChanged(dynamic val) {
    // debugPrint(val.toString());
  }

  @override
  Widget build(BuildContext context) {
    User user = widget.user;
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Update: ${user.name}"),
            actions: [
              IconButton(
                  onPressed: () => saving(), icon: const Icon(Icons.save_as))
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    FormBuilder(
                      key: _formKey,
                      initialValue: {
                        'name': user.name,
                        'username': user.name,
                        'email': user.name,
                        'street': user.address.suite,
                        'suite': user.address.suite,
                        'city': user.address.city,
                        'zip': user.address.zipcode,
                        'lat': user.address.geo.lat,
                        'lng': user.address.geo.lng,
                        'phone': user.phone,
                        'website': user.website,
                        'cpname': user.company.name,
                        'catchPhrase': user.company.catchPhrase,
                        'bs': user.company.bs,
                      },
                      onChanged: () {
                        _formKey.currentState!.save();
                        // debugPrint(_formKey.currentState!.value.toString());
                      },
                      autovalidateMode: AutovalidateMode.disabled,
                      skipDisabled: true,
                      child: Column(
                        children: <Widget>[
                          const SizedBox(height: 15),
                          FormBuilderTextField(
                            name: "name",
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              labelText: 'Name',
                            ),
                            textInputAction: TextInputAction.next,
                            onChanged: _onChanged,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.minLength(2),
                              FormBuilderValidators.maxLength(30),
                            ]),
                          ),
                          FormBuilderTextField(
                            name: "username",
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              labelText: 'Username',
                            ),
                            textInputAction: TextInputAction.next,
                            onChanged: _onChanged,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.minLength(2),
                              FormBuilderValidators.maxLength(30),
                            ]),
                          ),
                          FormBuilderTextField(
                            name: "email",
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                            ),
                            textInputAction: TextInputAction.next,
                            onChanged: _onChanged,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.email(),
                              FormBuilderValidators.minLength(5),
                            ]),
                          ),
                          FormBuilderTextField(
                            name: "street",
                            keyboardType: TextInputType.streetAddress,
                            decoration: const InputDecoration(
                              labelText: 'Street',
                            ),
                            textInputAction: TextInputAction.next,
                            onChanged: _onChanged,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.maxLength(50),
                              FormBuilderValidators.minLength(2),
                            ]),
                          ),
                          FormBuilderTextField(
                            name: "suite",
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              labelText: 'Suite',
                            ),
                            textInputAction: TextInputAction.next,
                            onChanged: _onChanged,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.maxLength(50),
                              FormBuilderValidators.minLength(2),
                            ]),
                          ),
                          FormBuilderTextField(
                            name: "city",
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              labelText: 'City',
                            ),
                            textInputAction: TextInputAction.next,
                            onChanged: _onChanged,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.maxLength(50),
                              FormBuilderValidators.minLength(2),
                            ]),
                          ),
                          FormBuilderTextField(
                            name: "zip",
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Zip Code',
                            ),
                            textInputAction: TextInputAction.next,
                            onChanged: _onChanged,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.minLength(2),
                            ]),
                          ),
                          FormBuilderTextField(
                            name: "lat",
                            keyboardType: const TextInputType.numberWithOptions(
                                signed: true, decimal: true),
                            decoration: const InputDecoration(
                              labelText: 'Latitude',
                            ),
                            textInputAction: TextInputAction.next,
                            onChanged: _onChanged,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.maxLength(15),
                              FormBuilderValidators.minLength(2),
                            ]),
                          ),
                          FormBuilderTextField(
                            name: "lng",
                            keyboardType: const TextInputType.numberWithOptions(
                                signed: true, decimal: true),
                            decoration: const InputDecoration(
                              labelText: 'Longititude',
                            ),
                            textInputAction: TextInputAction.next,
                            onChanged: _onChanged,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.maxLength(15),
                              FormBuilderValidators.minLength(2),
                            ]),
                          ),
                          FormBuilderTextField(
                            name: "phone",
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              labelText: 'Phone',
                            ),
                            textInputAction: TextInputAction.next,
                            onChanged: _onChanged,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.match(
                                  r'^[\+]?[0-9]{3}?[0-9]{3}?[0-9]{3,9}$'),
                              FormBuilderValidators.maxLength(15),
                              FormBuilderValidators.minLength(8),
                            ]),
                          ),
                          FormBuilderTextField(
                            name: "website",
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              labelText: 'Website',
                            ),
                            textInputAction: TextInputAction.next,
                            onChanged: _onChanged,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.maxLength(99),
                            ]),
                          ),
                          FormBuilderTextField(
                            name: "cpname",
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              labelText: 'Company Name',
                            ),
                            textInputAction: TextInputAction.next,
                            onChanged: _onChanged,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.maxLength(50),
                              FormBuilderValidators.minLength(2),
                            ]),
                          ),
                          FormBuilderTextField(
                            name: "catchPhrase",
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              labelText: 'CatchPhrase',
                            ),
                            textInputAction: TextInputAction.next,
                            onChanged: _onChanged,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.maxLength(250),
                            ]),
                          ),
                          FormBuilderTextField(
                            name: "bs",
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              labelText: 'bs',
                            ),
                            textInputAction: TextInputAction.done,
                            onChanged: _onChanged,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.maxLength(250),
                            ]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        onWillPop: () async {
          return !Loader.isShown;
        });
  }

  void saving() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      Loader.show(context,
          isSafeAreaOverlay: true,
          isBottomBarOverlay: true,
          // overlayFromBottom: 80,
          overlayColor: Colors.black45,
          progressIndicator:
              const CircularProgressIndicator(backgroundColor: Colors.red),
          themeData: Theme.of(context).copyWith(
              colorScheme:
                  ColorScheme.fromSwatch().copyWith(secondary: Colors.blue)));
      debugPrint(_formKey.currentState?.value.toString());
      // Time to save in backend
      setState(() {
        shouldPop = false;
      });
      Map<String, dynamic> fields = _formKey.currentState!.value;
      Company company = Company(
          name: fields['cpname'],
          catchPhrase: fields['catchPhrase'],
          bs: fields['bs']);
      Geo geo = Geo(lat: fields['lat'], lng: fields['lng']);
      Address address = Address(
          street: fields['street'],
          suite: fields['suite'],
          city: fields['city'],
          zipcode: fields['zip'],
          geo: geo);
      User newUser = User(
          id: 0,
          name: fields['name'],
          username: fields['username'],
          email: fields['email'],
          address: address,
          phone: fields['phone'],
          website: fields['website'],
          company: company);
      await UserRepository.updateUser(user: newUser, id: widget.user.id)
          .onError((error, stackTrace) {
        Loader.hide();
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(error.toString()),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("Close"))
                ],
              );
            });
        return null;
      }).then((value) {
        Loader.hide();
        if (value.runtimeType == User) {
          Navigator.pop(context);
        }
      });
    }
  }
}
