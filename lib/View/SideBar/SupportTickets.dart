import 'package:flutter/material.dart';
import 'package:my_amana_app/View/Menu/MenuSide.dart';
import 'package:my_amana_app/core/bootstrap/app_repositories.dart';
import 'package:my_amana_app/core/theme/app_theme.dart';
import 'package:my_amana_app/features/support/models/support_ticket.dart';
import 'package:my_amana_app/features/support/support_repository.dart';

class SupportTicketsPage extends StatefulWidget {
  const SupportTicketsPage({super.key});

  @override
  State<SupportTicketsPage> createState() => _SupportTicketsPageState();
}

class _SupportTicketsPageState extends State<SupportTicketsPage> {
  final SupportRepository _repository = AppRepositories.support;

  late Future<List<SupportTicket>> _future;
  bool _isSubmitting = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _trackingController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  String _category = 'Delivery issue';

  @override
  void initState() {
    super.initState();
    _future = _repository.fetchMyTickets();
  }

  @override
  void dispose() {
    _trackingController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _reload() async {
    setState(() {
      _future = _repository.fetchMyTickets();
    });
    await _future;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);
    try {
      await _repository.createTicket(
        category: _category,
        message: _messageController.text.trim(),
        trackingId: _trackingController.text.trim().isEmpty ? null : _trackingController.text.trim(),
      );
      if (!mounted) return;
      _messageController.clear();
      _trackingController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ticket submitted successfully.')),
      );
      await _reload();
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Something went wrong. Please try again.')),
      );
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appB(context),
      drawer: darweF(context),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildCreateCard(),
          const SizedBox(height: 16),
          const Text(
            'My tickets',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          FutureBuilder<List<SupportTicket>>(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              final tickets = snapshot.data ?? [];
              if (tickets.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text('No tickets yet.', style: TextStyle(color: AppColors.mutedText)),
                );
              }

              return Column(
                children: tickets.map((t) => _buildTicketTile(t)).toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCreateCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Create a support ticket',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _category,
                items: const [
                  DropdownMenuItem(value: 'Delivery issue', child: Text('Delivery issue')),
                  DropdownMenuItem(value: 'Tracking problem', child: Text('Tracking problem')),
                  DropdownMenuItem(value: 'Price / tariff', child: Text('Price / tariff')),
                  DropdownMenuItem(value: 'Other', child: Text('Other')),
                ],
                onChanged: _isSubmitting ? null : (v) => setState(() => _category = v ?? 'Other'),
                decoration: const InputDecoration(labelText: 'Category'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _trackingController,
                decoration: const InputDecoration(
                  labelText: 'Tracking ID (optional)',
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _messageController,
                minLines: 4,
                maxLines: 8,
                decoration: const InputDecoration(labelText: 'Message'),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return 'Message is required.';
                  }
                  if (v.trim().length < 8) {
                    return 'Please add more details (min 8 chars).';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _isSubmitting ? null : _submit,
                  icon: const Icon(Icons.send),
                  label: Text(_isSubmitting ? 'Submitting...' : 'Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTicketTile(SupportTicket t) {
    return Card(
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.support_agent, color: AppColors.primary),
        ),
        title: Text('${t.category} • ${t.status}', style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(
          (t.trackingId == null || t.trackingId!.trim().isEmpty)
              ? t.message
              : '[${t.trackingId}] ${t.message}',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
