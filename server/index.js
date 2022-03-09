const express = require('express');
const app = express();
const cors = require('cors');
const pool = require('./db');

// middlewares
app.use(cors());
app.use(express.json()); // req.body
app.use(express.urlencoded({ extended: false })); // req.query

// login the user
app.post('/users/login', (req, res) => {
  const { email, password } = req.body;
  pool.query(
    'SELECT * FROM users WHERE email = $1',
    [email],
    (err, results) => {
      if (err) {
        throw err;
      }
      if (results.rowCount > 0) {
        if (results.rows[0].password === password) {
          res.status(200).json({
            message: 'Login successful',
            name:results.rows[0].name,
            email: results.rows[0].email,
            statusCode: 200,
          });
        } else {
          res.status(401).json({
            message: 'Incorrect password',
            statusCode: 401,
          });
        }
      } else {
        res.status(404).json({
          message: 'User not found',
          statusCode: 404,
        });
      }
    }
  );
});

// register the user
app.post('/users/register', async (req, res) => {
  const { name, email, password } = req.body;
  // res.render('register');
  console.log(req.body);
  if (!name || !email || !password) {
    res
      .status(400)
      .json({ message: 'Please enter all the fields', statusCode: 400 });
  }

  pool.query('SELECT * FROM users WHERE email = $1', [email], (err, result) => {
    if (err) {
      throw err;
    }
    if (result.rows[0] == undefined) {
      pool.query(
        'INSERT INTO users (name, email, password) VALUES ($1, $2, $3) RETURNING *',
        [name, email, password],
        (err, result) => {
          if (err) {
            throw err;
          }
          console.log('User Successfully Registered!', result.rows[0]);
          res.status(200).json({
            message: 'User Successfully Registered!',
            statusCode: 200,
          });
        }
      );
    } else {
      console.log('User already exists!');
      res.status(409).json({ message: 'User Already Exist', statusCode: 409 });
    }
  });
});

const PORT = 5000;

app.listen(PORT, () => {
  console.log(`Server is running on port: ${PORT}`);
});
