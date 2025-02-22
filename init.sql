-- Cài đặt extension để hỗ trợ UUID
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Bảng users
CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email VARCHAR(255) UNIQUE NOT NULL,
  phone VARCHAR(50),
  password_hash VARCHAR(255) NOT NULL,
  avatar_url VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bảng candidates
CREATE TABLE candidates (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID UNIQUE NOT NULL,
  full_name VARCHAR(255) NOT NULL,
  joined_date DATE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bảng employers
CREATE TABLE employers (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID UNIQUE NOT NULL,
  company_id UUID,
  full_name VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bảng applications
CREATE TABLE applications (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  job_id UUID NOT NULL,
  resume_id UUID NOT NULL,
  applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  cover_letter TEXT
);

-- Bảng resumes
CREATE TABLE resumes (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  candidate_id UUID NOT NULL,
  name VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bảng resume_attachments
CREATE TABLE resume_attachments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  resume_id UUID NOT NULL,
  file_url VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bảng resume_nosql
CREATE TABLE resume_nosql (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  resume_id UUID NOT NULL,
  nosql_resume_object_id UUID,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bảng jobs
CREATE TABLE jobs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title VARCHAR(255) NOT NULL,
  employer_id UUID NOT NULL,
  salary_min INT,
  salary_max INT,
  years_of_experience INT,
  deadline DATE,
  vacancies INT,
  job_type VARCHAR(100),
  description TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bảng categories
CREATE TABLE categories (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(255) UNIQUE NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bảng job_categories
CREATE TABLE job_categories (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  job_id UUID NOT NULL,
  category_id UUID NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bảng companies
CREATE TABLE companies (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(255) UNIQUE NOT NULL,
  industry VARCHAR(255),
  company_size VARCHAR(100),
  logo_url VARCHAR(255),
  description TEXT,
  website VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bảng cities
CREATE TABLE cities (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(255) UNIQUE NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bảng job_cities
CREATE TABLE job_cities (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  job_id UUID NOT NULL,
  city_id UUID NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bảng wishlists
CREATE TABLE wishlists (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  job_id UUID NOT NULL,
  candidate_id UUID NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Thiết lập khóa ngoại
ALTER TABLE candidates ADD FOREIGN KEY (user_id) REFERENCES users (id);
ALTER TABLE employers ADD FOREIGN KEY (user_id) REFERENCES users (id);
ALTER TABLE employers ADD FOREIGN KEY (company_id) REFERENCES companies (id);
ALTER TABLE applications ADD FOREIGN KEY (job_id) REFERENCES jobs (id);
ALTER TABLE applications ADD FOREIGN KEY (resume_id) REFERENCES resumes (id);
ALTER TABLE resumes ADD FOREIGN KEY (candidate_id) REFERENCES candidates (id);
ALTER TABLE resume_attachments ADD FOREIGN KEY (resume_id) REFERENCES resumes (id);
ALTER TABLE resume_nosql ADD FOREIGN KEY (resume_id) REFERENCES resumes (id);
ALTER TABLE jobs ADD FOREIGN KEY (employer_id) REFERENCES employers (id);
ALTER TABLE job_categories ADD FOREIGN KEY (job_id) REFERENCES jobs (id);
ALTER TABLE job_categories ADD FOREIGN KEY (category_id) REFERENCES categories (id);
ALTER TABLE job_cities ADD FOREIGN KEY (job_id) REFERENCES jobs (id);
ALTER TABLE job_cities ADD FOREIGN KEY (city_id) REFERENCES cities (id);
ALTER TABLE wishlists ADD FOREIGN KEY (job_id) REFERENCES jobs (id);
ALTER TABLE wishlists ADD FOREIGN KEY (candidate_id) REFERENCES candidates (id);
