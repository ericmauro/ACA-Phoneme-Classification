# ACA-Phoneme-Classification

### "Automatic Speech Recognition: Classification of Phonemes"

### Final project for Audio Content Analysis course at NYU Tandon

#### Eric Mauro and Robert Schwartzberg

For this project, we used audio data from the TIMIT dataset to classify 61 different phonemes. We used MFCC's and Delta & DeltaDelta terms to create 72 features for each phoneme and used 4 different classifier methods: KNN, SVM, Random Forest, and a simple Neural Network. While the first three methods are adequate for smaller groupings of phonemes, the Neural Network was the most accurate when classifying all 61 phonemes with about 60% overall accuracy.

## Notable Files:
* **aca-phoneme-recognition.m**: loads scaled MFCC training and test data to classify phonemes using KNN, SVM, or Random Forest
* **phn_data_processing.m**: loads phoneme audio from TIMIT dataset to create training or test features
* **ACA-Phoneme-NN.ipynb**: Jupyter notebook with Neural Network classification
