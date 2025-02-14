const express = require('express');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');
const bodyParser = require('body-parser');
const cors = require('cors'); 

const app = express();
const port = 53000; 


let products = [
  {
    "name": "Product 1",
    "description": "Description of Product 1",
  },
  {
    "name": "Product 2",
    "description": "Description of Product 2",
  },
  {
    "name": "Product 3",
    "description": "Description of Product 3",
  },
  {
    "name": "Product 4",
    "description": "Description of Product 4",
  },

];

// Для использования секретного ключа и порта через переменные окружения
const SECRET_KEY = process.env.SECRET_KEY || 'your_secret_key';

app.use(cors()); // Разрешение запросов с любых источников
app.use(bodyParser.json()); // Для обработки JSON в запросах

// Регистрация пользователя
let users = [
  {
    'mail': 'qwe',
    'password': 'qwe'
  }
];


app.post('/register', async (req, res) => {
  const { login, mail, password } = req.body;

  if (!login || !mail || !password) {
    return res.status(400).json({ message: 'Login, mail and password are required' });
  }

  const userExists = users.find(user => user.mail === mail);
  if (userExists) {
    return res.status(400).json({ message: 'User with this email already exists' });
  }

  try {
    const hashedPassword = await bcrypt.hash(password, 10);
    const newUser = { login, mail, password: hashedPassword };
    users.push(newUser);

    res.status(201).json({ message: 'User registered successfully' });
  } catch (error) {
    res.status(500).json({ message: 'Internal server error' });
  }
});

// Логин пользователя
app.post('/login', async (req, res) => {
  const { mail, password } = req.body;

  if (!mail || !password) {
    return res.status(400).json({ message: 'Mail and password are required' });
  }

  const user = users.find(user => user.mail === mail);
  if (!user) {
    return res.status(400).json({ message: 'User not found' });
  }

  try {
    const isPasswordValid = await bcrypt.compare(password, user.password);
    if (!isPasswordValid) {
      return res.status(400).json({ message: 'Invalid password' });
    }

    const token = jwt.sign({ mail: user.mail, login: user.login }, SECRET_KEY, { expiresIn: '1h' });
    res.status(200).json({ token });
  } catch (error) {
    res.status(500).json({ message: 'Internal server error' });
  }
});

app.get('/product/:id', (req, res) => {
  const token = req.headers['authorization']?.split(' ')[1];

  if (!token) {
    return res.status(401).json({ message: 'Token is required' });
  }

  try {
    const decoded = jwt.verify(token, SECRET_KEY);
    const productId = req.params.id;
    const product = products[productId];  // Простое обращение к товару по индексу

    if (!product) {
      return res.status(404).json({ message: 'Product not found' });
    }

    res.status(200).json(product);
  } catch (error) {
    res.status(401).json({ message: 'Invalid or expired token' });
  }
});

app.get('/products', (req, res) => {
  res.json(products); // Возвращаем массив продуктов
});



// Запуск сервера
app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
