import numpy as np
import pandas as pd
from keras.models import Sequential
from keras.layers import Dense, Activation

model = Sequential()
model.add(Dense(32, activation='relu', input_dim=58))
model.add(Dense(1, activation='sigmoid'))
model.compile(optimizer='rmsprop',
              loss='mean_absolute_error',
              metrics=['accuracy'])

data = pd.read_csv("training.csv")
labels = data["logerror"]
data = data.drop("logerror", axis = 1)

model.fit(data, labels, epochs=10, batch_size=32)
