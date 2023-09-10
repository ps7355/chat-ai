import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:url_launcher/url_launcher.dart';

class PricingTable extends StatelessWidget {
  const PricingTable({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: const [
                SizedBox(
                  width: 15,
                ),
                PricingCards(
                  price: '\$6/month',
                  words: '600K Words',
                  query: 'Get 1500 words per query',
                  features: [
                    'Sharp & concise replies to your queries',
                    'One time login & seamless access',
                    'No country wise restriction',
                    'Less than 0.01% downtime',
                    '2x Faster query time'
                  ],
                ),
                SizedBox(
                  width: 15,
                ),
                PricingCards(
                  price: '\$12/month',
                  words: '600K Words',
                  query: 'Get 1500 words per query',
                  features: [
                    'Sharp & concise replies to your queries',
                    'One time login & seamless access',
                    'No country wise restriction',
                    'Less than 0.01% downtime',
                    '2x Faster query time'
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  width: 100,
                ),
                Text(
                  'Else, Continue With free Plan',
                  style: GoogleFonts.poppins(fontSize: 15),
                ),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    onPressed: () {},
                    child: Text(
                      'Continue with Free Plan',
                      style: GoogleFonts.poppins(),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

class PricingCards extends StatefulWidget {
  final String words;
  final String query;
  final List features;
  final String price;
  const PricingCards(
      {super.key,
      required this.words,
      required this.query,
      required this.features,
      required this.price});

  @override
  State<PricingCards> createState() => _PricingCardsState();
}

bool selectedPlan = false;

class _PricingCardsState extends State<PricingCards> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedPlan = !selectedPlan;
        });
      },
      child: Container(
        height: 450,
        width: 300,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: selectedPlan ? Color(0xff2dcb74) : Colors.black)),
        child: Column(
          children: [
            Text(widget.words,
                style: GoogleFonts.poppins(fontSize: 40, color: Colors.black)),
            SizedBox(
              height: 8,
            ),
            Text(
              widget.query,
              style: GoogleFonts.poppins(),
            ),
            const Divider(
              color: Colors.grey,
              indent: 2,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'What You\'ll Get',
              style: GoogleFonts.poppins(color: Colors.grey),
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.features.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Icon(Ionicons.checkmark_circle),
                        const SizedBox(
                          width: 3,
                        ),
                        Flexible(
                          child: Text(
                            widget.features[index],
                            style: GoogleFonts.poppins(),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(widget.price,
                style: GoogleFonts.poppins(fontSize: 20, color: Colors.black)),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 9),
              child: Container(
                  height: 40,
                  width: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      onPressed: () async {
                        const url = 'https://sivaiswinner.gumroad.com/l/csmcm';
                        if (await canLaunch(url)) {
                          await launchUrl(Uri.parse(url));
                        } else {
                          throw 'cant launch it';
                        }
                        Navigator.of(context, rootNavigator: true)
                            .pushNamed("/home");
                      },
                      child: Text(
                        'Choose this Plan',
                        style: GoogleFonts.poppins(color: Colors.white),
                      ))),
            )
          ],
        ),
      ),
    );
  }
}
