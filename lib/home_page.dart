import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<FormState> _formKey = GlobalKey();
  GlobalKey<FormFieldState> _nameKey = GlobalKey();
  GlobalKey<FormFieldState> _mailingListKey = GlobalKey();
  GlobalKey<FormFieldState> _termsKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Advanced Forms in Flutter"),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                key: _nameKey,
                decoration: InputDecoration(
                  labelText: "Name",
                ),
                validator: (valCandidate) {
                  if (valCandidate == null || valCandidate.isEmpty)
                    return "Please enter your name";
                  if (valCandidate != null && valCandidate.length < 3)
                    return "Name must be more than 3 characters long.";
                  return null;
                },
              ),
              FormField(
                key: _mailingListKey,
                validator: (valueCandidate) {
                  if (valueCandidate != true)
                    return 'You must accept terms and condtions';
                  return null;
                },
                builder: (FormFieldState<bool> field) => InputDecorator(
                  decoration: InputDecoration(
                    errorText: field.errorText,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Subscribe to mailing list",
                        style: TextStyle(
                          color: field.hasError
                              ? Theme.of(context).errorColor
                              : Colors.black,
                        ),
                      ),
                      Switch(
                        value: field.value ?? false,
                        onChanged: (val) {
                          field.didChange(val);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              FormField(
                key: _termsKey,
                validator: (valueCandidate) {
                  if (valueCandidate != true)
                    return 'You must accept terms and conditions';
                  return null;
                },
                builder: (FormFieldState<bool> field) => InputDecorator(
                  decoration: InputDecoration(
                    errorText: field.errorText,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Accept Terms and Conditions',
                        style: TextStyle(
                          color: field.hasError
                              ? Theme.of(context).errorColor
                              : Colors.black,
                        ),
                      ),
                      Checkbox(
                        value: field.value ?? false,
                        onChanged: (val) {
                          field.didChange(val);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RaisedButton(
                    child: Text('Submit'),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        print(_nameKey.currentState.value);
                        print(_mailingListKey.currentState.value);
                        print(_termsKey.currentState.value);
                      }
                    },
                  ),
                  RaisedButton(
                    child: Text('Reset'),
                    onPressed: () {
                      _formKey.currentState.reset();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
