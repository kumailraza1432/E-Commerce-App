import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fproject/Database/databasek.dart';
import 'package:fproject/Database/firebaseAuth.dart';
import 'package:fproject/Shared/constants.dart';
import 'package:fproject/models/user.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final Storage storage =Storage();
  GlobalKey _form = GlobalKey();
  Authservice _auth = Authservice();
  String pname='';
  String seller='';
  String description='';
  late int price;
  @override
  Widget build(BuildContext context) {
    final userr = Provider.of<personalUser?>(context);
    return Scaffold(
      appBar: myappbar(),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)) ,border: Border.all(width: 2,color: Colors.black45,style: BorderStyle.solid)),
          child: Form(
            key: _form,
            child: Column(
            children: [
              SizedBox(height: 20,),
              TextFormField(
                  decoration: mydecore.copyWith(hintText: 'Add Product Name'),
                  validator: (val){
                    if(val!.isEmpty){
                      return 'Enter a '
                          'product Name';
                    }
                    else{
                      return null;
                    }
                  },
                  onChanged: (val) {
                    setState(() {
                      pname = val;
                    });
                  }
              ),
              SizedBox(height: 20,),
              TextFormField(
                  decoration: mydecore.copyWith(hintText: 'Add Seller Name'),
                  validator: (val){
                    if(val!.isEmpty){
                      return 'Enter a Seller Name';
                    }
                    else{
                      return null;
                    }
                  },
                  onChanged: (val) {
                    setState(() {
                      seller = val;
                    });
                  }
              ),
              SizedBox(height: 20,),
              TextFormField(
                  decoration: mydecore.copyWith(hintText: 'Add Description'),
                  validator: (val){
                    if(val!.isEmpty){
                      return 'Enter Description';
                    }
                    else{
                      return null;
                    }
                  },
                  onChanged: (val) {
                    setState(() {
                      description = val;
                    });
                  }
              ),
              SizedBox(height: 20,),
              TextFormField(
                  decoration: mydecore.copyWith(hintText: 'Add Product Price'),
                  validator: (val){
                    if(val!.isEmpty){
                      return 'Enter a Price';
                    }
                    else{
                      return null;
                    }
                  },
                  onChanged: (val) {
                    setState(() {
                      price = val as int;
                    });
                  }
              ),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: () async{
                final results = await FilePicker.platform.pickFiles(
                  allowMultiple: false,
                  type: FileType.custom,
                  allowedExtensions: ['png','jpg']
                );
                if(results==null){
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No File Picked')));
                }
                final path = results?.files.single.path;
                final fileName = results?.files.single.name;
                print(path);
                storage.uploadFile(path!, fileName!);
                print(fileName);
                storage.uploadFile(path, fileName).then((value) => print('Done'));
              }, child: Text('Upload a Picture')),
              FutureBuilder(
                future: storage.listFiles(),
                builder: (BuildContext context, AsyncSnapshot<firebase_storage.ListResult> snapshot){
                  if(snapshot.connectionState==ConnectionState.done && snapshot.hasData){
                    return Container(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: snapshot.data!.items.length,
                        itemBuilder: (BuildContext context , int index){
                          return Text(snapshot.data!.items[index].name);
                        },
                      ),
                    );
                  }
                  if(snapshot.connectionState==ConnectionState.waiting || !snapshot.hasData){
                    return CircularProgressIndicator();
                  }
                    return Container();
                },
              ),
              FutureBuilder(
                future: storage.downloadURL('pakistan.PNG'),
                builder: (BuildContext context, AsyncSnapshot<String> snapshot){
                  if(snapshot.connectionState==ConnectionState.done && snapshot.hasData){
                    return Container(width: 300,height: 150,
                    child: Image.network(snapshot.data!,fit: BoxFit.cover,));
                  }
                  if(snapshot.connectionState==ConnectionState.waiting || !snapshot.hasData){
                    return Image.network('data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEA'
                        'AoHCBYVFRgVFhUZGBgYGBgYGBgYGBgYGBgYGBgZGRgYGBgcIS4lHB4rIRgY'
                        'JjgmKy8xNTU1GiQ7QDs0Py40NTEBDAwMEA8QHhISHzQrJCs0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NP/AABEIAMIBAwMBIgACEQEDEQH/xAAcAAABBQEBAQAAAAAAAAAAAAACAAEDBAUGBwj/xABBEAACAQIDBAYJAgQFAwUAAAABAgADEQQhMQUSQVEGMmFxgZETIkJSkqGxwdEU4WKCsvAVI0NTcjPC0gckJUSi/8QAGgEAAwEBAQEAAAAAAAAAAAAAAAECAwQFBv/EACcRAAICAQMEAQUBAQAAAAAAAAABAhEDEjFRBBMhQWEUMnGRoYEi/9oADAMBAAIRAxEAPwDSWpJVeUlaSo8+hPDLoMfcBkCPJkcRDRXxFdEZVd1VnyQE2LHLIc9R5w2pTnukrg4rCDk9/N0/E6q8mMrbRo4pJPkpNTgejMuFIvRyiaKPo4+5LhSRskBlYiMVk7JAYQAhtFDMaIBrxoRgmACvFGivAB4o1414gERBj3ivABgIisKK8YERWMVk9oDLFQFciAZYYQCsmhkMUJlgmMBQlkd4LV1GrAeIisVFm8Up/rU99PiEULQaWaAaGrSESQS7JonV5KryqpkimOxUYO3LPjMOpzHqn/8AZP2nVB5ye0DfHUexV+rzpw0yhu/ybS+1fgmDQg8hvFvTQzJ/SRt+Q70YtAdkzEQSBKz4pBq6jxEifaCDO5PcrH7RWgpltqciZJXO0OSMfhH3gfr2JICDLm34ENSHTLJWCZUq4p7E3UZe6T94zs59s+AUfaLUFFsmITMcesLu1rE9YjiOUB3pDrMv8zX+pk6x6TUdwNSB3kCRHEp76+BB+kzkxVJd43UZ5WHCw5Rm2vSBtvE9ymLWuR6HwzQ/VJwJPcrH7Rv1XJHPgB9SJlptdANGOvAcyecFttrwQ+JAi7keR9uXBZx+1mQoopm7tb1mAyyBOV+ctms/uL8Z/wDGcxtPaO+9Nt224Sdb3zU8uyWm24/BF+Zkd1W/JbxOlSN0VX/gHgx+4g06rsoJZRcA5Jz7zMI7Zqfw+R/Mh/xSoAAG0AGg4Q70fkOzL4OjKsfbbwCfiQVkNuu+qjUDVgOA7ZgPtOp7/wAl/EgfaLnWoeHtcs4nniNYZfB07Ycc2P8AO/5kbYVeV+8k/Uzl22i3Gqfj/eRNjhxqX/n/AHkvPHgfZlydNiMMgHUXrJwHvrH3UHBR5CcicWnFh5xji094SfqFwV2Xydf6VfeXzEU479anvfI/iND6hB2GekqslUSo2LHsqxzIvawyy45/KRrtBiL7qr3kt+J1a0cmhmkEhejmGdpi3rVbdi2H0zlb/FKYGe85udc+JtmxieWKKWOTBxtRf16G4ICi5GfBuXfN849L2AY+Fte+3KcTXxv/ALj0igAC2ROVt22dpLV2/Yk76LkBlnpfv5zFZlG/ybvE5VXB1z7QbKyDM2zbsJ0A7ID4p7H1gO4fkmcPW2/f22PcCPxKr7ZB9lj3mS+piNdOzuzihYFqvAe0B/TaVv1tIX3m3sza92y8ZwzbXbggHeSZG206h4gdw/Mh9Ui10/ydw200BuAdCNAOI/Ejq7XuCAmo1JnDNjKh9s+FhI2qOdXbzMh9TItYInb1dsPwCjvz+8rvtkj21F9erOMI7YrCS88hrDFHVvtwHWr5fsJXfbSHV2PxTnso4IkvLJlduKNo7YTkx8B+ZC+1VPsHzEy96Lf7JLnLkelGk22DwT5/tIjtVyb7q/OUd7sjb0Wp8j0ovHalT+EeH7yM7Rqe8PISmXk2Hw7OcshzMWqTCki3h8Q7bxZr2GWmWsqtiHPtt5y1TwzIGub3H0BmZvHnKbaSsIpWyc1HPtt8RgG/M+Zke92xr9siyqDKxbsC/b849+2KwC3Y27Bv2xXgAW7GtBvFAYUUG0UAOifpC2gdyM8gLaylU2uTovxG8y2uNRbwlzDbLxFS25QquDoVRyD4gWmjyTZChFDttGoeIHcPzIXxTnVz52+k28P0Ix7f/XZRzdlX5E3+U0qH/ptij12pp4sx+Q+8FGcvTB6Uc4x/yc88h/VKAI0AnYYTo1v4g4Nn6twXVfdUPkD5Tcqf+n1CmjuXdiiM4uVAuoJGQHZNHik/KJ1xR5s6Muq2gb81GTecCepdF9j0DhqbtRp7xBBYItzusVBOWtgJMcOp+GNzpHjQJOmfdnJ0wVVurTc9yMfoJ7yuCQdVVXuAEI4Yc5sulXt/wzeZ+keH0uj+KbTD1PFd3+q0t0uh+Mb/AEd3vZR9CZ7J+k7ZE9AiWulhyyHnnwjytOguKOvo172J+iyynQGtxqoPBj+J6QacbclrpsZDzzPPV6AN7WIXwQ/+UnXoInGu3ggH1JnclILU5SwY16JeafJxi9BqI1qVD8A+0lXoXhhqXP8AMB9BOqagZGaJldmHCJeWfJzg6JYYewx73b8yRejWGH+kD3sx+83TSPKRtTPKPtw4X6Frlyzhek2z6aMiJTRQRvEgete9rXPCZ1FLToOk6f5q/wDAfUzGK2nHkSUnR1wbcVY+GAaogIuC6g30NyMp2o2TR/2U+BfxONwKn0iGxsHXMDTMazuBUvoZthqvJjmu1RF/htL/AGk+BfxHGz6Y0pp8C/iSb8W/N/BhbBGFQewnwj8R/Qr7i+QhB4t6OkLyRPRX3R5CRmivujyEnZ5GzxUBAaY5DyEBlHIeUmd5A7QGNYcooG/FEM4PC4m1gbMOIYXE9t6O49Hw9MU2QhURdxGvuEKPVtqLTwJGImhg8VYgglWHI2PgZ5+LJXhnfKN7H0ItQ8Vhh14g+U8x2N0xdQEqsTyfj/MOPeJ1dDbRYAhgwOhBBE61UtjFzcdzF2KVba9YnS9T5KBO121RT9NWIYZUqh1/gaedbCxX/wAhVfmavzadXtnaF8PVFtabjzUiTpbVpl9yK8NHk9FP8weP0nsvRjBscJSPNSfNmnj1Iev5/Se29FNo0lwtFSSCEAPmZipSirirNYqEvuCqYZhwldlInRpjKJ9seJ/aR4hKbA+suh4iNdS190WD6eMvtZz++Y4N5rUNklkU3vdVN7jMkCIbCc8QJoupxv2ZPp5Lj9mUKSn2rQWwq+98poV9kOovlbvlZ8K4Fzp2ESlmjLZieKSV0U2w/IyJkMmR731yZh8JI+0K81UjJxRUYW1nO4rpbQRymbEG1gCc+WQ17Ju7bqBKFRhwRvMi33nkmyAWxVI88TSHiaizLJlcaSKhiTts7t+ltMao6/8AJHH/AGRk6Y4Y6vbwb7gT0rEbTpp16iJkes6jS3M9sy8T0hwgH/UV/wDgpf8ApBi7svZknF7L+nmG2tp0a7h1rIAFA9Y2N7k8u2Z1x7DI7cAHQnyJnoG0uk2HZKm5h6j2VvWGHNlIU9Ykerbtnj2GwbuBuoW61iOdhbwBz8Zhll/t8HVhd/Fcm5WxNZcmWx5by/mBR2lUQ3a45cvPSSUHKooq0ySFqgsVvctSApXPY4JJJ0OXa9VsO1ja1v0+8o37ONw/qLXzFnAtnxykaPFpm/cezRoYTb5uAc++dNg66VBdTnxHGcNtTZyUj6Sg+/RPH2kJ9lxrbk3hrqeA2iVIIMqGaUJVLyjOeCORXHwzvCogtaVsDtJagAbJvkf3ll6c7ozUlaOCUHF0yNjImMJ0MiZTHZIDmQtJWSAywGiK0UfciisZ5tuxBDwh2itPJPSLOGxRGTef5mrhNotTO9TdRfVCRut4cD2iYjEjI8POJnGhF5pGbRLimdTsjHolZqjsEDbxzuQCxvbKbOO23TdHRaitvLYAE534ZziMU9k8R9JFhKnria95p6TJ4k/+jWpmz3753+xsWvokAIyUC1xfynndNvWlKu/rt3mNZNHmhuOpUezpX5EQq1c7jZ+y30M8ap4516ruO5j+Zdo7fxCggVWIIIIbPXLjH9TF+iO3JbM9cw20HRE3XIG6NOQQn7S+u1Kp/wBQ2755PQ6U4ggLZWAFgd3s3db8jNXDbbrKvrBcz2+reUtEvNfwbc17PRDtZ7gFr99jp4SJdoM6qWAOQPL6Tz3EdIK6ZikDYHO5YZ8cpmt0txIyBVbZZLy75L7cXt/ClPI1uelYKuCCdwdep3ddu2WmqL7i+F8vnPJF6S4kCwfiT1RqxJPzJjHpLif9z5CJ5I/ILUuD0DpS4/S1rZep/wBwnjqVSDll6wa/HKbeI21WdSjuSrCxHMTJFMBt4HMG/D6ETOc1Jqioqrs7bop0iZNxDhaTlW3t8oqO2RHrvYlutr/CJ3mO6YFVsmGVyACVFTd1926WI4cJ43R2nVQWVx8CknvPGE22K5YNvi4Nx6g8Qc9JeqDXm7I0O/FUdVj+k7ili1GHI9KjuzF7ej3wtOw9X17F15Tk9mbTbdCe7ay34bqqSO/dF5YfaGIqU3UlStRd1vVztvA5XbI3UTEfCuuXZ2DjfnzmeR27RrijWyOoTFjMm3K35j1UWqjIoRWJU726L+qu6BfULblOVTEsMjNTB4rtkqTNWkwDUek26bq3yI59ogufX3wFzN8gAPADSbiVEqLuOAR8x2g8JHQ2WqG6tvDhfUD7xU/QauRYUleFvrOhwOODKd5gCDbMgEi0yUpgSti8RSp2aoha+QIF7cbazfE9LOfMtaOlfFJ76/EJC+MT30+IfmcwdrYT/bPw/vI12jhbklDmcstBYZa87zd5Vyjn7T4Z07Y1PfT4hImxie+nxCYP67CH2D5H8wf1WE935N+Yd1coO18M3f1ae+vxCKcvVxFG53Vy4daKHc/BXaRiGImPGnnHWPeMTFHgBdxnU8RKdBrMPrLeK6vjKioToJpN+SVsalIne1lN29Y95k+Fwz+HM8PGThETPrsT3Lfu1MpxckIr08KWz0HM6DxlvC4VSd1RvnidEH5kyYdnsXNl5aDwHCaFKmqiwFhylQxoTY+Gw6ra5BP07hLToN25INza3ZIM4VQeqB/fOb7EEeHxno23H0v6p18LyzXw9N9VF/nM7E0Q69oGUjwWJ9hza2QJ4dhk3Xhg17QeI2QPYaZtbBOvC/dN0oYivd85MoRYJtHNMCNcoJM6GphQeX28pQrbO5fL8GZPG/RakZpaAzyxVwbD98j+JUqIV1BHfM2mhmrhc0A53+shfCE+35iFhOovd95YC2mqimlYKTWxkVMOyjgYKVJexfVPcZRwiXup7xIlHTsXGV7l2hijNXB4kzIVLS1QPKKNls3HNxcTK21T3qZ7CD9j8jLNCtDxCh1K8wR5y27RnVHGxSRlsSDqMvKAfGZDGvFD3Mr3HdBK2gA14ot2KABWj2iVSdJMmGJ1gk2BFaSJQY8Jew+E7LScuqjLM/KWockuRClEnVcv4tIaKiX48uXlInrltJLhsIWNz/fdNN34JFvO+Q0/vSWsPhQuZzMsJTC6Q1mijyKxgt5MD2wbwllCCZo7HheJNRHc8e2MAKetjpfOUMZQ3TfwMu79jGcBl+smStB7IsDi/YY9x5dhl5kmJVplDY+Bl7A4y1kfTgfsZKfoJL2i5aMRJGHdG8JRNkToDrK7YJToSPp5S5aDaIdmY+CYaC/dl8pXqBtBr2jSbdu2A6A6i8VDswBh3A9YHPU2J8pEXCHJbd/bN84a3VYj6StXwxOqhh2fiTKPgakZpG9mNLRJVtJjTC5C47DwlbEDjMaaZtdqy6lcGWPSZTGR5oYZ75R2CM3aCgOTbJs/z8wZV35t7Swt03rZrn4cZh3HCSxDHviEQWFuc4gBvFCt2RQoDVp4fwHb+JIHRdMz8pUfE7395QUBM2tLYzrkmrYont7BpI0pltfKSUcPf8zRw9ID8xqLkDdEdDCjj/ffLQyjFuUSzRKtiRxJBAyj3EYEgh5SNbQsowCUxMuUSCM1v7MAAcQhaC5HbBDQAHEICpHHUGZq5ZaTWddD4yljKdrMOORkSQ0WMDi7eq+nA8uwzTKznFMv4HF2sjaeyeXZ3QjImUfaNIrBJhmRsRKJQDQbxM0YtEWOI9oIbsMXpOYMAGemDqLzFxVEo1j1T1Tz7O+be/2GQ4hd9Su7r3ZHgYpRTQ4yowWS0OlUtAcEEg8JE72znMbGwMUN3PlOaqABjbS+XdCrYgnLhIYm7AtUquVrC8PfB6w8pUUy3SpMwupB5jiIJtksDOKH6N/dijoLLCIBLdKjfXKNRp2lxZvGJk2GiWhM0jLxrywJRHEBYUYBAxAZxo6wAkEZowMeMAhpGMYRXgMYwbQrwDEIlQ5WgNxB0goLHUx3zi3Q3S2M2p6rEZ/W44WMcG8u1aRYZZEacjM9WOnLUTPYZqYDHAeo+nBuXYZosnETm9ZobPx+76jHLgeXYZal6ZMo+0aDLAMmqHlIWWOhJiigxFoDE2Wd5E1dQCbg2BJsQdJz22qrNUKk5Law4ZjWZkyllp1RaiXKmM3rltSSfA6Sq9QmBFMW7NBRRRRAISfC1N1uyQRxBOgNyz9vmIpkLimGQJHjFNNaI0s6FbCFeRAwwZ0GQUdYIhQGFvQrwLxXgBIDCBkawrwsA7x1MAmPHYEl4BMYmMTBgPeMY14iYgHJjwL2+kJTAAlPCVcbQ9sdlxLDSRTvCKSBMygYjCxFPdbXI6GDIKL2Ax27ZXOXA8uwzUc3znOmWsHjd0hW6vDs7+yWpckuPs02EAyQwWEYkYHSGjmrjTqnv1H3mHO0r0VZSrC4P93nLY/ANSOeanQ/Y8jMMkfNm0ZeipFFFMihRRRoAPFGjwAUUUUAOjENZCpkgM7DnJQYryMGGIAPeEJHvQhAZIDFvQY14AFeEpkcdYASFoxMBWyiJgAV4jBvETAB2j3kZMcGKwJrwVexgqYzQYEmJp74tlzExw5BsdRr2eE0tSM/nl5SPG4Ydcfza+chlJlUNFFbz+URMALeCxpWyN1eB5ftNQtOeaXMBjN31G6vA8o1LkTRpmQYqiHRl5jLsPAyxYeBgMJTQkziqiFSQRYg2IgzY29h7MHGhyPeNPl9JjzllGnRsnaFFFFEMUUUUAHiiigB0Cwoop1+jnDEcRRQASw1iijBjmCI8UQxR1+0UUEAy6COYooAOYxiigAJiiiiAdY8UUYAjXxlhtD3R4pLBGQvV84y8YooimMY50iikjNjBdRe+TNFFNY7EGdtj/pN3r/UJzMUUwy7msdhooopkUKKKKMB4oooAf/Z');
                  }
                  return Container();
                },
              ),
              SizedBox(width: 200,height: 50, child: FlatButton.icon(color: Colors.green,
                  onPressed: () async{
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Product Uploaded')));
                    await DatabaseService(uid: userr!.uid).addProduct(pname, seller, description, price);
                    Navigator.pop(context);
                  }, icon: Icon(Icons.add), label: Text('Add Product',style: TextStyle(fontSize: 20),)))
            ],
          ),)
        )
      ),
    );
  }
}
