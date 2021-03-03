import tensorflow as tf
import tensorflow_datasets as tfds

from keras.models import Sequential

class encoder(tf.keras.Model):
    def __init__(self): 
        super(encoder, self).__init__()
        self.conv1 = tf.keras.layers.Conv2D(filters=64,kernel_size=(3,3),padding='same')
        self.drop = tf.keras.layers.Dropout(0.5)
        self.conv2 = tf.keras.layers.Conv2D(filters=128,kernel_size=(3,3),padding='same')
        self.pool = tf.keras.layers.MaxPooling2D((2,2))
        self.relu = tf.keras.layers.ReLU()
        self.bn = tf.keras.layers.BatchNormalization()

    def call(self,x, train=False):
        x = self.bn(self.relu(self.conv1(x)))
        x = self.pool(x)
        x = self.bn(self.relu(self.conv2(x))) 
        x = self.pool(x)

        return x 


class bottleneck(tf.keras.Model):
    def __init__(self):
        super(bottleneck, self).__init__()
        self.conv1 = tf.keras.layers.Conv2D(filters=256,kernel_size=(3,3),activation="relu",padding='same')
        self.relu = tf.keras.layers.ReLU()
        self.encoder_visualization = tf.keras.layers.Conv2D(filters=1, kernel_size=(3,3), activation='sigmoid', padding='same')
        self.bn  = tf.keras.layers.BatchNormalization()

    def call(self,x): 
        x = self.bn(self.relu(self.conv1(x))) 
        vis = self.encoder_visualization(x)


        return x, vis 



class decoder(tf.keras.Model):
    def __init__(self): 
        super(decoder, self).__init__()
        self.conv1 = tf.keras.layers.Conv2D(filters=128,kernel_size=(3,3),padding='same',)
        self.conv2 = tf.keras.layers.Conv2D(filters=64,kernel_size=(3,3),padding='same')
        self.conv3 = tf.keras.layers.Conv2D(filters=3,kernel_size=(3,3),padding='same')
        self.upsample = tf.keras.layers.Upsample2D((2,2))
        self.relu = tf.keras.layers.ReLU()
        self.bn = tf.keras.layers.BatchNormalization()

    def call(self,x): 
        x = self.bn(self.relu(self.conv1(x)))
        x = self.upsample(x)
        x = self.bn(self.relu(self.conv2(x)))
        x = self.upsample(x)
        x = self.bn(self.relu(self.conv3(x)))


       

