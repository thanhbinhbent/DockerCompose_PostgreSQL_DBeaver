-- Cài đặt extension để hỗ trợ UUID
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Tạo ENUM mới
CREATE TYPE job_type_enum AS ENUM ('full_time', 'part_time', 'contract', 'internship', 'freelance');
CREATE TYPE industry_enum AS ENUM (
    'accounting', 'airlines_aviation', 'alternative_dispute_resolution', 'alternative_medicine', 'animation',
    'apparel_fashion', 'architecture_planning', 'arts_crafts', 'automotive', 'aviation_aerospace',
    'banking', 'biotechnology', 'broadcast_media', 'building_materials', 'business_supplies_equipment',
    'capital_markets', 'chemicals', 'civic_social_organization', 'civil_engineering', 'commercial_real_estate',
    'computer_network_security', 'computer_games', 'computer_hardware', 'computer_networking', 'computer_software',
    'construction', 'consumer_electronics', 'consumer_goods', 'consumer_services', 'cosmetics',
    'dairy', 'defense_space', 'design', 'education_management', 'e_learning',
    'electrical_electronic_manufacturing', 'entertainment', 'environmental_services', 'events_services',
    'executive_office', 'facilities_services', 'farming', 'financial_services', 'fine_art',
    'fishery', 'food_beverages', 'food_production', 'fundraising', 'furniture',
    'gambling_casinos', 'glass_ceramics_concrete', 'government_administration', 'government_relations',
    'graphic_design', 'health_wellness_fitness', 'higher_education', 'hospital_health_care',
    'hospitality', 'human_resources', 'import_export', 'individual_family_services', 'industrial_automation',
    'information_services', 'information_technology_services', 'insurance', 'international_affairs',
    'international_trade_development', 'internet', 'investment_banking_venture', 'investment_management',
    'judiciary', 'law_enforcement', 'law_practice', 'legal_services', 'legislative_office',
    'leisure_travel', 'libraries', 'logistics_supply_chain', 'luxury_goods_jewelry', 'machinery',
    'management_consulting', 'maritime', 'marketing_advertising', 'market_research', 'mechanical_industrial_engineering',
    'media_production', 'medical_device', 'medical_practice', 'mental_health_care', 'military',
    'mining_metals', 'motion_pictures_film', 'museums_institutions', 'music', 'nanotechnology',
    'newspapers', 'nonprofit_organization_management', 'oil_energy', 'online_publishing', 'outsourcing_offshoring',
    'package_freight_delivery', 'packaging_containers', 'paper_forest_products', 'performing_arts', 'pharmaceuticals',
    'philanthropy', 'photography', 'plastics', 'political_organization', 'primary_secondary',
    'printing', 'professional_training', 'program_development', 'public_policy', 'public_relations',
    'public_safety', 'publishing', 'railroad_manufacture', 'ranching', 'real_estate',
    'recreational_facilities_services', 'religious_institutions', 'renewables_environment', 'research', 'restaurants',
    'retail', 'security_investigations', 'semiconductors', 'shipbuilding', 'sporting_goods',
    'sports', 'staffing_recruiting', 'supermarkets', 'telecommunications', 'textiles',
    'think_tanks', 'tobacco', 'translation_localization', 'transportation_trucking_railroad', 'utilities',
    'venture_capital', 'veterinary', 'warehousing', 'wholesale', 'wine_spirits',
    'wireless', 'writing_editing'
);
CREATE TYPE company_size_enum AS ENUM ('small', 'medium', 'large', 'enterprise');

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
  user_id UUID UNIQUE NOT NULL REFERENCES users(id),
  full_name VARCHAR(255) NOT NULL,
  joined_date DATE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bảng companies
CREATE TABLE companies (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(255) UNIQUE NOT NULL,
  industry industry_enum NOT NULL,
  company_size company_size_enum NOT NULL,
  logo_url VARCHAR(255),
  description TEXT,
  website VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bảng employers
CREATE TABLE employers (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID UNIQUE NOT NULL REFERENCES users(id),
  company_id UUID REFERENCES companies(id),
  full_name VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bảng jobs
CREATE TABLE jobs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title VARCHAR(255) NOT NULL,
  employer_id UUID NOT NULL REFERENCES employers(id),
  salary_min INT,
  salary_max INT,
  years_of_experience INT,
  deadline DATE,
  vacancies INT,
  job_type job_type_enum NOT NULL,
  description TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bảng applications
CREATE TABLE applications (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  job_id UUID NOT NULL REFERENCES jobs(id),
  resume_id UUID NOT NULL,
  applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  cover_letter TEXT
);

-- Bảng resumes
CREATE TABLE resumes (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  candidate_id UUID NOT NULL REFERENCES candidates(id),
  name VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bảng resume_attachments
CREATE TABLE resume_attachments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  resume_id UUID NOT NULL REFERENCES resumes(id),
  file_url VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bảng resume_nosql
CREATE TABLE resume_nosql (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  resume_id UUID NOT NULL REFERENCES resumes(id),
  nosql_resume_object_id UUID,
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
  job_id UUID NOT NULL REFERENCES jobs(id),
  category_id UUID NOT NULL REFERENCES categories(id),
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
  job_id UUID NOT NULL REFERENCES jobs(id),
  city_id UUID NOT NULL REFERENCES cities(id),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bảng wishlists
CREATE TABLE wishlists (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  job_id UUID NOT NULL REFERENCES jobs(id),
  candidate_id UUID NOT NULL REFERENCES candidates(id),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
