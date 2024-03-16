import 'dart:convert';

import 'package:homework_api/models/country.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class TimeTable extends StatefulWidget {
  const TimeTable({Key? key});

  @override
  State<TimeTable> createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  List<Country>? _countries;
  List<Country>? _filteredCountries;

  @override
  void initState() {
    super.initState();
    _fetchCountries();
  }

  Future<void> _fetchCountries() async {
    var dio = Dio(BaseOptions(responseType: ResponseType.plain));
    var response = await dio.get('https://api.sampleapis.com/countries/countries');
    print('Status code: ${response.statusCode}');
    response.headers.forEach((name, values) {
      print('$name: $values');
    });
    print(response.data.toString());

    setState(() {
      List list = jsonDecode(response.data.toString());
      _countries = list.map((item) => Country.fromJson(item)).toList();
      _filteredCountries = _countries;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _filteredCountries == null
        ? Center(child: CircularProgressIndicator())
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: _filterCountries,
                  decoration: InputDecoration(
                    labelText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _filteredCountries!.length,
                  itemBuilder: (context, index) {
                    var country = _filteredCountries![index];

                    return ListTile(
                      title: Text(country.name ?? ''),
                      subtitle: Text('Capital: ${country.capital ?? ''}'),
                      trailing: country.flag == ''
                          ? null
                          : Image.network(
                              country.flag ?? '',
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(Icons.error, color: Colors.red);
                              },
                            ),
                      onTap: () {
                        _showCountryInfoDialog(country);
                      },
                    );
                  },
                ),
              ),
            ],
          );
  }

  void _filterCountries(String value) {
    setState(() {
      _filteredCountries = _countries?.where((country) =>
          country.name!.toLowerCase().contains(value.toLowerCase())).toList();
    });
  }

  void _showCountryInfoDialog(Country country) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Country Information'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name: ${country.name ?? ''}'),
              Text('Capital: ${country.capital ?? ''}'),
              Text('Population: ${country.population?.toString() ?? 'Unknown'}'),
              
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
