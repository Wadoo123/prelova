import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class UploadProductPage extends StatefulWidget {
  const UploadProductPage({super.key});

  @override
  State<UploadProductPage> createState() => _UploadProductPageState();
}

class _UploadProductPageState extends State<UploadProductPage> {
  final _formKey = GlobalKey<FormState>();

  // --- UI State ---
  int _condition = 1; // 0 for New, 1 for Used

  // --- Data & Controllers ---
  final List<File> _productImages = [];
  final ImagePicker _picker = ImagePicker();

  // Static field controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();

  // Dynamic field state
  String? _selectedCategory;
  String? _selectedSubCategory;
  List<String> _availableSubCategories = [];
  Map<String, TextEditingController> _dynamicFieldControllers = {};

  // --- Category Definitions ---
  final Map<String, Map<String, dynamic>> _categories = {
    'Mobile Phone': {
      'subCategories': [],
      'fields': ['Chipset', 'RAM (GB)', 'Storage (GB)', 'Screen Size (inch)'],
    },
    'Laptop': {
      'subCategories': ['Ultrabook', 'Gaming', 'Workstation'],
      'fields': ['Processor', 'RAM (GB)', 'Storage (GB)', 'Graphics Card', 'Screen Size (inch)'],
    },
    'Audio Device': {
      'subCategories': ['Headphone', 'TWS', 'Earphone', 'Speaker'],
      'fields': ['Connectivity', 'Color', 'Features'],
    },
    'Television': {
      'subCategories': [],
      'fields': ['Screen Size (inch)', 'Resolution', 'Smart TV (Yes/No)'],
    },
    'Camera': {
      'subCategories': ['DSLR', 'Mirrorless', 'Action Cam'],
      'fields': ['Sensor Size', 'Megapixels', 'Lens Mount'],
    }
  };

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _brandController.dispose();
    _clearDynamicControllers();
    super.dispose();
  }

  void _clearDynamicControllers() {
    for (var controller in _dynamicFieldControllers.values) {
      controller.dispose();
    }
    _dynamicFieldControllers.clear();
  }

  void _onCategoryChanged(String? newValue) {
    if (newValue == null || newValue == _selectedCategory) return;
    setState(() {
      _selectedCategory = newValue;
      _selectedSubCategory = null;
      _availableSubCategories = List<String>.from(_categories[newValue]!['subCategories']);
      _clearDynamicControllers();
      final fields = List<String>.from(_categories[newValue]!['fields']);
      for (var field in fields) {
        _dynamicFieldControllers[field] = TextEditingController();
      }
    });
  }

  Future<void> _pickImage() async {
    if (_productImages.length >= 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You can upload a maximum of 5 images.')),
      );
      return;
    }
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _productImages.add(File(pickedFile.path));
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _productImages.removeAt(index);
    });
  }

  Future<String?> _showCategoryPickerModal({
    required BuildContext context,
    required String title,
    required List<String> items,
    String? initialValue,
  }) async {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        String? tempSelected = initialValue;
        return AlertDialog(
          title: Text(title, style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
          contentPadding: const EdgeInsets.only(top: 20.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              children: items.map((item) {
                return StatefulBuilder(
                  builder: (context, setState) {
                    return RadioListTile<String>(
                      title: Text(item, style: const TextStyle(fontFamily: 'Poppins')),
                      value: item,
                      groupValue: tempSelected,
                      onChanged: (String? value) {
                        setState(() {
                          tempSelected = value;
                        });
                      },
                    );
                  },
                );
              }).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel', style: TextStyle(fontFamily: 'Poppins')),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Done', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold)),
              onPressed: () => Navigator.of(context).pop(tempSelected),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      appBar: AppBar(
        title: const Text('Sell Your Item'),
        titleTextStyle: const TextStyle(
          fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 17, color: Colors.black,
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFF2F2F7),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle("Product Images"),
              _buildImagePicker(),
              const SizedBox(height: 24),

              _buildSectionTitle("Main Details"),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    _buildCupertinoTextField(label: "Product Name", controller: _nameController, hint: "e.g., Macbook Pro 14-inch (Used)"),
                    _buildCupertinoTextField(label: "Brand", controller: _brandController, hint: "e.g., Apple"),
                    _buildCupertinoTextField(label: "Price", controller: _priceController, hint: "15,000,000", keyboardType: TextInputType.number, prefixText: "Rp "),
                    _buildCupertinoTextField(label: "Description", controller: _descriptionController, hint: "Describe the item's condition, history, etc.", maxLines: 4, isLast: true),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              _buildSectionTitle("Categorization"),
              _buildCategoryPickerField(
                  label: 'Category',
                  value: _selectedCategory,
                  onTap: () async {
                    final selected = await _showCategoryPickerModal(context: context, title: 'Select Category', items: _categories.keys.toList(), initialValue: _selectedCategory);
                    if (selected != null) _onCategoryChanged(selected);
                  }
              ),
              if (_availableSubCategories.isNotEmpty) ...[
                const SizedBox(height: 12),
                _buildCategoryPickerField(
                    label: 'Sub-Category',
                    value: _selectedSubCategory,
                    onTap: () async {
                      final selected = await _showCategoryPickerModal(context: context, title: 'Select Sub-Category', items: _availableSubCategories, initialValue: _selectedSubCategory);
                      if (selected != null) setState(() => _selectedSubCategory = selected);
                    }
                ),
              ],
              const SizedBox(height: 24),

              if (_dynamicFieldControllers.isNotEmpty) ...[
                _buildSectionTitle("Item Specifics"),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                  child: _buildDynamicFields(),
                ),
                const SizedBox(height: 24),
              ],

              _buildSectionTitle("Condition"),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("What is the condition of the item?", style: TextStyle(fontFamily: 'Poppins', fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: CupertinoSlidingSegmentedControl<int>(
                        groupValue: _condition,
                        backgroundColor: const Color(0xFFF2F2F7),
                        thumbColor: Colors.white,
                        children: const {0: Text('New', style: TextStyle(fontFamily: 'Poppins')), 1: Text('Used', style: TextStyle(fontFamily: 'Poppins'))},
                        onValueChanged: (value) {
                          if (value != null) setState(() => _condition = value);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                child: CupertinoButton.filled(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) { /* Handle upload logic */ }
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: const Text('Upload Product', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 16)),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDynamicFields() {
    final fieldKeys = _dynamicFieldControllers.keys.toList();
    return Column(
      children: List.generate(fieldKeys.length, (index) {
        final key = fieldKeys[index];
        return _buildCupertinoTextField(label: key, controller: _dynamicFieldControllers[key]!, hint: "Enter ${key.toLowerCase()}", isLast: index == fieldKeys.length - 1);
      }),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(fontFamily: 'Poppins', color: Colors.grey.shade600, fontSize: 13, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildImagePicker() {
    return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: 10, mainAxisSpacing: 10),
          itemCount: _productImages.length + 1,
          itemBuilder: (context, index) {
            if (index == _productImages.length) {
              if (_productImages.length < 5) {
                return GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    decoration: BoxDecoration(color: const Color(0xFFF2F2F7), borderRadius: BorderRadius.circular(8)),
                    child: const Icon(CupertinoIcons.camera_fill, color: Color(0xFFC7C7CC)),
                  ),
                );
              }
              return const SizedBox.shrink();
            }
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.file(_productImages[index], fit: BoxFit.cover),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: GestureDetector(
                      onTap: () => _removeImage(index),
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(color: Colors.black.withOpacity(0.5), shape: BoxShape.circle),
                        child: const Icon(Icons.close, color: Colors.white, size: 14),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        )
    );
  }

  Widget _buildCupertinoTextField({
    required String label,
    required TextEditingController controller,
    String hint = '',
    int maxLines = 1,
    bool isLast = false,
    TextInputType? keyboardType,
    String? prefixText,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Row(
            children: [
              SizedBox(
                width: 100, // Consistent label width
                child: Text(label, style: const TextStyle(fontFamily: 'Poppins', fontSize: 15, fontWeight: FontWeight.w500)),
              ),
              Expanded(
                child: TextFormField(
                  controller: controller,
                  maxLines: maxLines,
                  keyboardType: keyboardType,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hint,
                    hintStyle: TextStyle(fontFamily: 'Poppins', color: Colors.grey.shade400, fontSize: 15),
                    prefixText: prefixText,
                  ),
                  style: const TextStyle(fontFamily: 'Poppins', fontSize: 15),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'This field is required';
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
        if (!isLast) Divider(height: 1, color: Colors.grey.shade200, indent: 100)
      ],
    );
  }

  Widget _buildCategoryPickerField({
    required String label,
    required String? value,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontFamily: 'Poppins', fontSize: 15, fontWeight: FontWeight.w500)),
            Row(
              children: [
                Text(
                  value ?? 'Not selected',
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 15, color: value != null ? Colors.black : Colors.grey.shade500),
                ),
                const SizedBox(width: 8),
                const Icon(CupertinoIcons.chevron_up_chevron_down, color: Color(0xFFC7C7CC), size: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
