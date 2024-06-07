import 'package:flutter/material.dart';
import '../Services/pedido_service.dart';
import '../Class/pedido.dart';

class CreatePedidoPage extends StatefulWidget {
  @override
  _CreatePedidoPageState createState() => _CreatePedidoPageState();
}

class _CreatePedidoPageState extends State<CreatePedidoPage> {
  final _formKey = GlobalKey<FormState>();
  final _clienteController = TextEditingController();
  final _enderecoDestinoController = TextEditingController();
  final _produtoController = TextEditingController();
  final _dataEntregaPrevistaController = TextEditingController();
  final _localizacaoAtualController = TextEditingController();
  final _statusEntregaController = TextEditingController();

  @override
  void dispose() {
    _clienteController.dispose();
    _enderecoDestinoController.dispose();
    _produtoController.dispose();
    _dataEntregaPrevistaController.dispose();
    _localizacaoAtualController.dispose();
    _statusEntregaController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      Pedido pedido = Pedido(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        cliente: _clienteController.text,
        enderecoDestino: _enderecoDestinoController.text,
        produto: _produtoController.text,
        dataEntregaPrevista: _dataEntregaPrevistaController.text,
        localizacaoAtual: _localizacaoAtualController.text,
        statusEntrega: _statusEntregaController.text,
      );

      await PedidoService().createPedido(pedido);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pedido criado com sucesso!')),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Pedido'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _clienteController,
                decoration: InputDecoration(labelText: 'Cliente'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'cliente';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _enderecoDestinoController,
                decoration: InputDecoration(labelText: 'Endereço de Destino'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Destino';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _produtoController,
                decoration: InputDecoration(labelText: 'Produto'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Produto';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dataEntregaPrevistaController,
                decoration: InputDecoration(
                  labelText: 'Data de Entrega ',
                  hintText: 'YYYY-MM-DD',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'insira a data de entrega prevista';
                  }
                  return null;
                },
                keyboardType: TextInputType.datetime,
              ),
              TextFormField(
                controller: _localizacaoAtualController,
                decoration: InputDecoration(labelText: 'Localização Atual'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a localização atual';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _statusEntregaController,
                decoration: InputDecoration(labelText: 'Status da Entrega'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o status da entrega';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Criar Pedido'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
