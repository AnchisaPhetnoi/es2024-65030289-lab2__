# ใช้ Node.js เป็นเบสภาพ
FROM node:14

# ตั้งค่าโฟลเดอร์ทำงาน
WORKDIR /usr/src/app

# คัดลอกไฟล์ package.json และ package-lock.json
COPY package*.json ./

# ติดตั้ง dependencies
RUN npm install

# คัดลอกไฟล์ทั้งหมดไปยัง container
COPY . .

# เปิดพอร์ต 3000
EXPOSE 3000

# สั่งให้รันแอป
CMD [ "node", "app.js" ]

